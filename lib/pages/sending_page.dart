import 'dart:io';

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

class SendingPage extends StatefulWidget {
  const SendingPage(
      {super.key, required this.files, required this.isFolder, required this.launchedByIntent});

  final List<String> files;
  final bool isFolder;
  final bool launchedByIntent;

  @override
  State<SendingPage> createState() => _SendingPageState();
}

class _SendingPageState extends State<SendingPage> {
  final log = getLogger();
  final _prefs = SharedPrefs();

  String codeText = '';
  double? shareProgress;
  int? totalShareSize;
  String? zipFilePath;

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

    if (widget.isFolder) {
      final folderPath = widget.files.last;
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

        zipStream.listen((e) async {
          if (e.zipFilePath != null) {
            zipFilePath = e.zipFilePath;
            startTransfer([e.zipFilePath!]);
          }
        });
      } catch (e) {
        if (mounted) {
          Navigator.of(context).pop();
          await showErrorDialog(context: context, errorMessage: t.pages.send.zip_failed);
        }
      }
    } else {
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

    stream.listen((e) async {
      switch (e.event) {
        case Events.code:
          setState(() {
            codeText = e.getValue().toString();
          });
          break;
        case Events.total:
          setState(() {
            totalShareSize = e.getValue() as int;
          });
          break;
        case Events.startTransfer:
          setState(() {
            codeText = '';
            shareProgress = 0;
          });
        case Events.sent:
          setState(() {
            shareProgress = (e.getValue() as int) / totalShareSize!.toDouble();
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
    super.dispose();

    FilePicker.platform.clearTemporaryFiles();

    if(zipFilePath != null) {
      File(zipFilePath!).delete();
    }
  }

  @override
  Widget build(BuildContext context) {
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
          child: codeText == ''
              ? Padding(
                  padding: const EdgeInsets.all(14),
                  child: LinearProgressIndicator(
                    value: shareProgress,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(18),
                  ))
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: QrImageView(
                                data: 'wormhole-transfer:$codeText', backgroundColor: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox.fromSize(size: Size.fromHeight(10)),
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(26),
                          onTap: _copyCode,
                          child: Padding(
                              padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
                              child: Row(mainAxisSize: MainAxisSize.min, children: [
                                Text(codeText,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontSize: 17)),
                                IconButton(
                                  onPressed: _copyCode,
                                  icon: const Icon(Icons.copy),
                                ),
                              ])),
                        ),
                      ),
                      //SizedBox.fromSize(size: Size.fromHeight(10)),
                      //IconButton(onPressed: () => {}, icon: const Icon(Icons.refresh))
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  void _copyCode() {
    Clipboard.setData(ClipboardData(text: codeText));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Copied code to clipboard'),
    ));
  }
}
