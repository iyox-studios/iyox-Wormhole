import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iyox_wormhole/i18n/strings.g.dart';
import 'package:iyox_wormhole/pages/sending_page.dart';
import 'package:iyox_wormhole/rust/api.dart';
import 'package:iyox_wormhole/rust/wormhole/types/events.dart';
import 'package:iyox_wormhole/rust/wormhole/types/t_update.dart';
import 'package:iyox_wormhole/rust/wormhole/types/value.dart';
import 'package:iyox_wormhole/utils/error_dialog.dart';
import 'package:iyox_wormhole/utils/logger.dart';
import 'package:iyox_wormhole/utils/shared_prefs.dart';
import 'package:iyox_wormhole/utils/type_helpers.dart';
import 'package:path_provider/path_provider.dart';

class ReceivingPage extends StatefulWidget {
  const ReceivingPage({super.key, required this.code});

  final String code;

  @override
  State<ReceivingPage> createState() => _ReceivingPageState();
}

class _ReceivingPageState extends State<ReceivingPage> {
  int totalReceiveBytes = 0;
  String humanReadableTotalSize = '';
  int receivedBytes = 0;
  bool transferring = false;
  bool downloadStarted = false;
  final _prefs = SharedPrefs();
  StreamSubscription<TUpdate>? _transferSubscription;
  String fileName = '';
  String connectionTypeInfo = '';
  String statusMessage = '';
  bool isFinished = false;
  String? finalFilePath;

  @override
  void initState() {
    super.initState();
    startReceiving();
  }

  @override
  void dispose() {
    _transferSubscription?.cancel();
    super.dispose();
  }

  void startReceiving() async {
    final downloadPath = await getDownloadsDirectory();

    if (downloadPath == null) {
      if (mounted) {
        Navigator.of(context).pop();
      }
      return;
    }

    final t = Translations.of(context);
    setState(() {
      statusMessage = t.pages.receive.status_connecting;
    });

    final serverConfig = ServerConfig(
      rendezvousUrl: _prefs.rendezvousUrl,
      transitUrl: _prefs.transitUrl,
    );

    final stream = requestFile(
        code: widget.code,
        storageFolder: downloadPath.path,
        serverConfig: serverConfig);

    setState(() {
      transferring = true;
      downloadStarted = false;
    });

    _transferSubscription = stream.listen((e) async {
      final t = Translations.of(context);
      debugPrint(e.event.toString());
      switch (e.event) {
        case Events.startTransfer:
          setState(() {
            downloadStarted = true;
            statusMessage = t.pages.receive.status_transferring;
          });
          break;
        case Events.finished:
          var finishedValue = e.getValue() as String;

          var extractedName = finishedValue.split('/').last;
          setState(() {
            transferring = false;
            isFinished = true;
            fileName = extractedName;
            statusMessage = t.pages.receive.status_finished(
                name: extractedName.isNotEmpty ? extractedName : 'Unknown');
          });
          break;

        case Events.sent:
          setState(() {
            receivedBytes = e.getValue() as int;
          });
          break;
        case Events.total:
          setState(() {
            final totalValue = e.getValue();
            totalReceiveBytes = totalValue is int ? totalValue : 0;
            humanReadableTotalSize = formatBytes(totalReceiveBytes, 2);
          });
          break;

        case Events.error:
          debugPrint('Error: ${e.getValue()}');
          final errorMessage =
              e.getValue()?.toString() ?? t.common.generic_error;

          if (mounted) {
            Navigator.of(context).pop();
            await showErrorDialog(context: context, errorMessage: errorMessage);
          }
          break;
        case Events.connectionType:
          if (e.value is Value_ConnectionType) {
            final connectionType = e.value as Value_ConnectionType;
            setState(() {
              connectionTypeInfo = connectionType.field1;
            });
          }
          break;
        default:
          getLogger().w('Unknown event: ${e.event.toString()}');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (fileName.isNotEmpty)
                Text(fileName,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center),
              if (humanReadableTotalSize.isNotEmpty)
                Text(humanReadableTotalSize,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center),
              const SizedBox(height: 15),
              if (!isFinished)
                LinearProgressIndicator(
                  value: downloadStarted && totalReceiveBytes > 0
                      ? receivedBytes / totalReceiveBytes
                      : null,
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(18),
                ),
              const SizedBox(height: 15),
              Text(statusMessage,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center),
              if (connectionTypeInfo.isNotEmpty && !isFinished) ...[
                const SizedBox(height: 5),
                Text(connectionTypeInfo,
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center),
              ],
              if (isFinished) ...[
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Optionally, open the downloaded file/folder
                    // if (finalFilePath != null) { ... }
                  },
                  child: Text(t.common.generic_acknowledge),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
