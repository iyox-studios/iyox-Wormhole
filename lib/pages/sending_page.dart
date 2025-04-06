import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iyox_wormhole/i18n/strings.g.dart';
import 'package:iyox_wormhole/rust/api.dart';
import 'package:iyox_wormhole/rust/wormhole/types/events.dart';
import 'package:iyox_wormhole/rust/wormhole/types/t_update.dart';
import 'package:iyox_wormhole/rust/wormhole/types/value.dart';
import 'package:iyox_wormhole/utils/error_dialog.dart';
import 'package:iyox_wormhole/utils/logger.dart';
import 'package:iyox_wormhole/utils/shared_prefs.dart';
import 'package:iyox_wormhole/utils/type_helpers.dart';
import 'package:iyox_wormhole/utils/zip.dart';
import 'package:pick_or_save/pick_or_save.dart';
import 'package:qr_flutter/qr_flutter.dart';

String formatBytes(int bytes, int decimals) {
  if (bytes <= 0) return '0 B';
  const suffixes = ['B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
  var i = (log(bytes) / log(1024)).floor();
  return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
}

class SendingPage extends StatefulWidget {
  const SendingPage({super.key, required this.files, required this.isFolder, required this.launchedByIntent});

  final List<String> files;
  final bool isFolder;
  final bool launchedByIntent;

  @override
  State<SendingPage> createState() => _SendingPageState();
}

class _SendingPageState extends State<SendingPage> {
  final log = getLogger();
  final _prefs = SharedPrefs();
  StreamSubscription<TUpdate>? _transferSubscription;
  StreamSubscription<ZipProgress>? _zipSubscription;

  String codeText = '';
  double? shareProgress;
  int? totalShareSize;
  String humanReadableTotalSize = '';
  String? zipFilePath;
  bool isZipping = false;
  double zipProgress = 0.0;
  String connectionTypeInfo = '';
  String statusMessage = '';

  @override
  void initState() {
    super.initState();

    _startSending();
  }

  void _startSending() async {
    if (widget.files.isEmpty) {
      Navigator.of(context).pop();
      return;
    }

    setState(() {
      statusMessage = t.pages.send.status_initializing;
    });

    if (widget.isFolder) {
      final folderPath = widget.files.last;
      setState(() {
        isZipping = true;
        statusMessage = t.pages.send.status_zipping;
      });
      List<DocumentFile>? documentFiles = await PickOrSave().directoryDocumentsPicker(
        params: DirectoryDocumentsPickerParams(
          directoryUri: folderPath,
          recurseDirectories: true,
        ),
      );

      if (documentFiles == null) {
        if (mounted) {
          Navigator.of(context).pop();
          await showErrorDialog(context: context);
        }
        return;
      }

      try {
        final zipStream = zipFolder(folderPath, documentFiles);

        _zipSubscription = zipStream.listen((e) async {
          setState(() {
            if (e.totalFiles > 0) {
              zipProgress = e.processedFiles.toDouble() / e.totalFiles.toDouble();
            } else {
              zipProgress = 0.0;
            }

            if (zipProgress < 1.0) {
              statusMessage =
                  t.pages.send.status_zipping_progress(progress: '${(zipProgress * 100).toStringAsFixed(0)}%');
            }
          });
          if (e.zipFilePath != null) {
            zipFilePath = e.zipFilePath;
            setState(() {
              isZipping = false;
              statusMessage = t.pages.send.status_starting_transfer;
            });
            startTransfer([e.zipFilePath!]);
          }
        });
      } catch (e) {
        if (mounted) {
          setState(() {
            isZipping = false;
          });
          Navigator.of(context).pop();
          await showErrorDialog(context: context, errorMessage: t.pages.send.zip_failed);
        }
      }
    } else {
      setState(() {
        statusMessage = t.pages.send.status_starting_transfer;
      });
      startTransfer(widget.files);
    }
  }

  void startTransfer(List<String> files) {
    final codeLength = _prefs.codeLength;
    final serverConfig = ServerConfig(
      rendezvousUrl: _prefs.rendezvousUrl,
      transitUrl: _prefs.transitUrl,
    );

    Stream<TUpdate> stream = sendFiles(
      name: files.first.split('/').last,
      filePaths: files,
      codeLength: codeLength,
      serverConfig: serverConfig,
    );

    _transferSubscription = stream.listen((e) async {
      final t = Translations.of(context);
      switch (e.event) {
        case Events.code:
          setState(() {
            codeText = e.getValue().toString();
            statusMessage = t.pages.send.status_waiting;
          });
          break;
        case Events.total:
          setState(() {
            final total = e.getValue();
            totalShareSize = total is int ? total : 0;
            humanReadableTotalSize = formatBytes(totalShareSize ?? 0, 2);
          });
          break;
        case Events.startTransfer:
          setState(() {
            codeText = '';
            shareProgress = 0;
            statusMessage = t.pages.send.status_transferring;
          });
          break;
        case Events.sent:
          setState(() {
            final sent = e.getValue();
            if (totalShareSize != null && totalShareSize! > 0 && sent is int) {
              shareProgress = sent / totalShareSize!.toDouble();
            } else {
              shareProgress = 0.0;
            }
          });
          break;
        case Events.finished:
          if (widget.launchedByIntent) {
            SystemNavigator.pop();
            return;
          }
          if (mounted) {
            Navigator.of(context).pop();
          }
          break;
        case Events.error:
          final String errorMessage;
          if (e.value is Value_Error) {
            final err = e.value as Value_Error;
            log.e('Native Error: ${err.field0}');
            errorMessage = err.field0.toString();
          } else if (e.value is Value_ErrorValue) {
            final err = e.value as Value_ErrorValue;
            log.e('Native Error: ${err.field0}, ${err.field1}');
            errorMessage = err.field1;
          } else {
            errorMessage = 'Unexpected Error';
          }

          if (mounted) {
            Navigator.of(context).pop();
            await showErrorDialog(context: context, errorMessage: errorMessage);
          }
          break;
        case Events.connectionType:
          if (e.value is Value_ConnectionType) {
            final connectionType = e.value as Value_ConnectionType;
            setState(() {
              connectionTypeInfo = t.pages.send.connection_info(type: connectionType.field1);
            });
          }
          break;
        default:
          log.w('Unknown event: ${e.event.toString()}');
      }
    });
  }

  Future<bool?> _showBackDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        final t = Translations.of(context);
        return AlertDialog(
          title: Text(t.pages.send.abort_transfer_title),
          content: Text(t.pages.send.abort_transfer_message),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
              child: Text(t.pages.send.abort_transfer_no),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(textStyle: Theme.of(context).textTheme.labelLarge),
              child: Text(t.pages.send.abort_transfer_yes),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _transferSubscription?.cancel();
    _zipSubscription?.cancel();
    super.dispose();

    FilePicker.platform.clearTemporaryFiles();

    if (zipFilePath != null) {
      File(zipFilePath!).delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          if (didPop) {
            return;
          }
          final bool shouldPop = await _showBackDialog() ?? false;
          if (context.mounted && shouldPop) {
            if (widget.launchedByIntent) {
              await SystemNavigator.pop();
            } else {
              Navigator.pop(context);
            }
          }
        },
        child: Center(
          child: isZipping
              ? _ZippingIndicator(
                  zipProgress: zipProgress,
                  statusMessage: statusMessage,
                )
              : codeText == ''
                  ? _TransferProgressIndicator(
                      shareProgress: shareProgress,
                      totalSize: humanReadableTotalSize,
                      connectionInfo: connectionTypeInfo,
                      statusMessage: statusMessage,
                    )
                  : _CodeDisplay(
                      codeText: codeText,
                      onCopyCode: _copyCode,
                      totalSize: humanReadableTotalSize,
                      connectionInfo: connectionTypeInfo,
                      statusMessage: statusMessage,
                    ),
        ),
      ),
    );
  }

  void _copyCode() {
    final t = Translations.of(context);
    Clipboard.setData(ClipboardData(text: codeText));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(t.pages.send.clipboard_copied),
    ));
  }
}

class _ZippingIndicator extends StatelessWidget {
  const _ZippingIndicator({
    required this.zipProgress,
    required this.statusMessage,
  });

  final double zipProgress;
  final String statusMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LinearProgressIndicator(
            value: zipProgress > 0 ? zipProgress : null, // Indeterminate if progress is 0
            minHeight: 10,
            borderRadius: BorderRadius.circular(18),
          ),
          const SizedBox(height: 15),
          Text(statusMessage, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _TransferProgressIndicator extends StatelessWidget {
  final double? shareProgress;
  final String totalSize;
  final String connectionInfo;
  final String statusMessage;

  const _TransferProgressIndicator({
    this.shareProgress,
    required this.totalSize,
    required this.connectionInfo,
    required this.statusMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(totalSize, style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center),
          const SizedBox(height: 15),
          LinearProgressIndicator(
            value: shareProgress,
            minHeight: 10,
            borderRadius: BorderRadius.circular(18),
          ),
          const SizedBox(height: 15),
          Text(statusMessage, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
          if (connectionInfo.isNotEmpty) ...[
            const SizedBox(height: 5),
            Text(connectionInfo, style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center),
          ]
        ],
      ),
    );
  }
}

class _CodeDisplay extends StatelessWidget {
  final String codeText;
  final VoidCallback onCopyCode;
  final String totalSize;
  final String connectionInfo;
  final String statusMessage;

  const _CodeDisplay({
    required this.codeText,
    required this.onCopyCode,
    required this.totalSize,
    required this.connectionInfo,
    required this.statusMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: QrImageView(data: 'wormhole-transfer:$codeText', backgroundColor: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
            child: InkWell(
              borderRadius: BorderRadius.circular(26),
              onTap: onCopyCode,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Flexible(
                    child: Text(
                      codeText,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 17),
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                  ),
                  IconButton(
                    onPressed: onCopyCode,
                    icon: const Icon(Icons.copy),
                  ),
                ]),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(totalSize, style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center),
          const SizedBox(height: 15),
          Text(statusMessage, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
