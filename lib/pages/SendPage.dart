import 'package:animations/animations.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:iyox_wormhole/gen/ffi.dart';
import 'package:iyox_wormhole/widgets/RecentFiles.dart';

import 'SendingPage.dart';

class SendPage extends StatefulWidget {
  const SendPage({Key? key}) : super(key: key);

  @override
  State<SendPage> createState() => _SendPageState();
}

final ButtonStyle largeButtonStyle = ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(200),
    ),
  ),
  fixedSize: MaterialStateProperty.all<Size>(const Size(150, 60)),
);

class _SendPageState extends State<SendPage> {
  String code = '';

  static final ButtonStyle buttonStyle = ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(200),
      ),
    ),
    fixedSize: MaterialStateProperty.all<Size>(const Size(150, 60)),
  );

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 55, 0, 20),
          child: Text("Send Files", style: TextStyle(fontSize: 37)),
        ),
        const RecentFiles(),
        if (code != '')
          Card(
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
                  Text(code, style: Theme.of(context).textTheme.titleMedium),
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: code));
                    },
                    icon: const Icon(Icons.copy),
                  ),
                ],
              ),
            ),
          ),
        Expanded(
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FilledButton.icon(
                      onPressed: _onSendButtonClick,
                      style: buttonStyle,
                      label: const Text('Send File'),
                      icon: const Icon(Icons.file_open),
                    ),
                    const Gap(46),
                    FilledButton.icon(
                      onPressed: null,
                      style: buttonStyle,
                      label: const Text('Send Folder'),
                      icon: const Icon(Icons.drive_folder_upload),
                    ),
                  ],
                ))),
        const Gap(30)
      ],
    ));
  }

  Future<ServerConfig> getServerConfig() async {
    final rendezvousUrl = await api.defaultRendezvousUrl();
    final transitUrl = await api.defaultTransitUrl();
    final serverConfig =
        ServerConfig(rendezvousUrl: rendezvousUrl, transitUrl: transitUrl);
    return serverConfig;
  }

  void _onSendButtonClick() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: false);

    if (context.mounted) {
      if (result != null) {
        Navigator.push(context, _createSendingRoute(result));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No files selected'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  Route _createSendingRoute(FilePickerResult files) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SendingPage(
        files: files,
      ),
      transitionDuration: const Duration(milliseconds: 0),
      reverseTransitionDuration: const Duration(milliseconds: 380),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeThroughTransition(
              secondaryAnimation: secondaryAnimation,
              animation: animation,
              child: child),
    );
  }
}
