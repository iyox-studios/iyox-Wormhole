import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:iyox_wormhole/type_helpers.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../gen/ffi.dart';

class SendingPage extends StatefulWidget {
  const SendingPage({Key? key, required this.files}) : super(key: key);

  final FilePickerResult files;

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startSending();
    });
  }

  Future<void> _startSending() async {
    final files =
        widget.files.files.where((element) => element.path != null).toList();

    final stream = api.sendFiles(
        name: files.first.name,
        filePaths: files.map((e) => e.path!).toList(),
        codeLength: 3,
        serverConfig: await _getServerConfig());

    stream.listen((e) {
      setState(() {
        switch (e.event) {
          case Events.Code:
            codeText = e.getValue().toString();
            break;
          case Events.Total:
            totalShareSize = e.getValue();
            break;
          case Events.StartTransfer:
            codeText = '';
            shareProgress = 0;
          case Events.Sent:
            shareProgress = e.getValue() / totalShareSize.toDouble();
          case Events.Finished:
            Navigator.of(context).pop();
          default:
            debugPrint(e.event.toString());
        }
      });
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
            debugPrint(constraints.maxWidth.toString());
            if (constraints.maxWidth > 600) {
              return _buildWideContainer();
            } else {
              return _buildNormaContainer();
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

  Widget _buildNormaContainer() {
    return Center(
      child: codeText == ''
          ? Padding(
              padding: const EdgeInsets.all(10),
              child: LinearProgressIndicator(
                value: shareProgress,
                minHeight: 10,
                borderRadius: BorderRadius.circular(18),
              ))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                    margin: const EdgeInsets.all(20),
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
    final rendezvousUrl = await api.defaultRendezvousUrl();
    final transitUrl = await api.defaultTransitUrl();
    final serverConfig =
        ServerConfig(rendezvousUrl: rendezvousUrl, transitUrl: transitUrl);
    return serverConfig;
  }
}
