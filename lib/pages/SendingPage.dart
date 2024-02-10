import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iyox_wormhole/type_helpers.dart';

import '../gen/ffi.dart';

class SendingPage extends StatefulWidget {
  const SendingPage({Key? key, required this.files}) : super(key: key);

  final FilePickerResult files;

  @override
  State<SendingPage> createState() => _SendingPageState();
}

class _SendingPageState extends State<SendingPage> {
  String statusText = "";

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
      switch (e.event) {
        case Events.Code:
          setState(() {
            statusText = e.getValue().toString();
          });
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: statusText == ''
            ? LinearProgressIndicator(
                value: null,
                minHeight: 10,
                borderRadius: BorderRadius.circular(18),
              )
            : Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                margin: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(statusText,
                          style: Theme.of(context).textTheme.titleMedium),
                      IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: statusText));
                        },
                        icon: const Icon(Icons.copy),
                      ),
                    ],
                  ),
                ),
              ),
      ),
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
