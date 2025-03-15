import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iyox_wormhole/i18n/strings.g.dart';
import 'package:iyox_wormhole/rust/api.dart';
import 'package:iyox_wormhole/rust/wormhole/types/events.dart';
import 'package:iyox_wormhole/rust/wormhole/types/t_update.dart';
import 'package:iyox_wormhole/rust/wormhole/types/value.dart';
import 'package:iyox_wormhole/utils/logger.dart';
import 'package:iyox_wormhole/utils/type_helpers.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SendingPage extends StatefulWidget {
  const SendingPage({super.key, required this.files, required this.isFolder});

  final List<String> files;
  final bool isFolder;

  @override
  State<SendingPage> createState() => _SendingPageState();
}

class _SendingPageState extends State<SendingPage> {
  final log = getLogger();

  String codeText = '';
  double? shareProgress;
  int? totalShareSize;

  @override
  void initState() {
    super.initState();

    _startSending();
  }

  void _startSending() {
    if (widget.files.isEmpty) {
      Navigator.of(context).pop();
      return;
    }

    Stream<TUpdate> stream;
    if (!widget.isFolder) {
      stream = sendFiles(
        name: widget.files.first.split('/').last,
        filePaths: widget.files,
        codeLength: 3, //await Settings.getWordLength(),
        serverConfig: new ServerConfig(
          rendezvousUrl: defaultRendezvousUrl(),
          transitUrl: defaultTransitUrl(),
        ),
      );
      //await _getServerConfig());
    } else {
      String folderPath = widget.files.first;
      String folderName = folderPath.split('/').last;

      stream = sendFolder(
        name: folderName,
        folderPath: folderPath,
        codeLength: 3, //await Settings.getWordLength(),
        serverConfig: new ServerConfig(
          rendezvousUrl: defaultRendezvousUrl(),
          transitUrl: defaultTransitUrl(),
        ),
      );
    }

    /*
    for (var file in widget.files) {
      setState(() {
        Settings.addRecentFile(file);
      });
    }
    */

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
        case Events.finished:
          /*if (widget.causedByIntent) {
            SystemNavigator.pop();
            return;
          }*/
          if (mounted) {
            Navigator.of(context).pop();
          }
        case Events.error:
          final errMessage = e.value as Value_ErrorValue;
          log.e('Native Error: ${errMessage.field0}, ${errMessage.field1}');
          if (mounted) {
            Navigator.of(context).pop();
            await showDialog<void>(
                context: context,
                builder: (ctx) {
                  final t = Translations.of(ctx);

                  return AlertDialog(
                    title: Text(t.common.generic_error),
                    content: Text(errMessage.field1),
                    actions: [
                      TextButton(
                          onPressed: () =>
                              Navigator.of(ctx, rootNavigator: true).pop(),
                          child: Text(t.common.generic_acknowledge))
                    ],
                  );
                },
                barrierDismissible: true);
          }
        default:
          log.e(e.event.toString());
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
              style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge),
              child: Text(t.pages.send.abort_transfer_no),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge),
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
            Navigator.pop(context);
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
                                    data: 'wormhole-transfer:$codeText',
                                    backgroundColor: Colors.white),
                              ))),
                      SizedBox.fromSize(
                        size: Size.fromHeight(10),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(26),
                          onTap: () {
                            Clipboard.setData(ClipboardData(text: codeText));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Copied code to clipboard'),
                            ));
                          },
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 13, vertical: 9),
                              child: Text(
                                codeText,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    height: 1.6,
                                    fontSize: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .fontSize! +
                                        1.5,
                                    fontWeight: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.fontWeight),
                              )),
                        ),
                      ),
                      //const Gap(10),
                      //IconButton(onPressed: () => {_refreshCode()}, icon: const Icon(Icons.refresh))
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
