import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:iyox_wormhole/utils/settings.dart';
import 'package:iyox_wormhole/utils/type_helpers.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../gen/ffi.dart';

class SendingPage extends StatefulWidget {
  const SendingPage(
      {Key? key,
      required this.files,
      this.folder = false,
      this.causedByIntent = false})
      : super(key: key);

  final List<String> files;
  final bool folder;
  final bool causedByIntent;

  @override
  State<SendingPage> createState() => _SendingPageState();
}

class _SendingPageState extends State<SendingPage> {
  String codeText = "";
  double? shareProgress;
  int totalShareSize = 0;

  @override
  void initState() {
    super.initState();

    _startSending();
  }

  Future<void> _startSending() async {
    if (widget.files.isEmpty) {
      Navigator.of(context).pop();
      return;
    }

    Stream<TUpdate> stream;
    if (!widget.folder) {
      stream = api.sendFiles(
          name: widget.files.first.split('/').last,
          filePaths: widget.files,
          codeLength: await Settings.getWordLength(),
          serverConfig: await _getServerConfig());
    } else {
      stream = api.sendFolder(
          folderPath: widget.files.first,
          name: widget.files.first.split('/').last,
          codeLength: await Settings.getWordLength(),
          serverConfig: await _getServerConfig());
    }

    for (var file in widget.files) {
      setState(() {
        Settings.addRecentFile(file);
      });
    }

    stream.listen((e) {
      switch (e.event) {
        case Events.Code:
          setState(() {
            codeText = e.getValue().toString();
          });
          break;
        case Events.Total:
          setState(() {
            totalShareSize = e.getValue();
          });
          break;
        case Events.StartTransfer:
          setState(() {
            codeText = '';
            shareProgress = 0;
          });
        case Events.Sent:
          setState(() {
            shareProgress = e.getValue() / totalShareSize.toDouble();
          });
        case Events.Finished:
          if (widget.causedByIntent) {
            SystemNavigator.pop();
            return;
          }
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        default:
          debugPrint(e.event.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) {
          return;
        }
        _showBackDialog();
      },
      child: Scaffold(
          appBar: AppBar(),
          body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 600) {
              return _buildWideContainer();
            } else {
              return _buildNormalContainer();
            }
          })),
    );
  }

  Widget _buildWideContainer() {
    return Center(
      child: codeText == ''
          ? Padding(
              padding: const EdgeInsets.all(10),
              child: LinearProgressIndicator(
                value: shareProgress,
                minHeight: 10,
                borderRadius: BorderRadius.circular(18),
              ))
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  margin: const EdgeInsets.all(30),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: QrImageView(
                        data: "wormhole-transfer:$codeText",
                        backgroundColor: Colors.white,
                        size: 300,
                      ),
                    ),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(codeText,
                            style: Theme.of(context).textTheme.titleMedium),
                        IconButton(
                          onPressed: () {
                            Clipboard.setData(ClipboardData(text: codeText));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Copied code to clipboard"),
                            ));
                          },
                          icon: const Icon(Icons.copy),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildNormalContainer() {
    return Center(
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
                                data: "wormhole-transfer:$codeText",
                                backgroundColor: Colors.white),
                          ))),
                  const Gap(10),
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
                          content: Text("Copied code to clipboard"),
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
                ],
              ),
          ),
    );
  }

  void _showBackDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text(
            'Leaving this page will cancel the transfer',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Leave'),
              onPressed: () {
                if (widget.causedByIntent) {
                  SystemNavigator.pop();
                  return;
                }
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<ServerConfig> _getServerConfig() async {
    final rendezvousUrl = await Settings.getRendezvousUrl();
    final transitUrl = await Settings.getTransitUrl();
    final serverConfig =
        ServerConfig(rendezvousUrl: rendezvousUrl, transitUrl: transitUrl);
    return serverConfig;
  }
}
