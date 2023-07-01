import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iyox_wormhole/type_helpers.dart';

import '../gen/ffi.dart';

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
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton.icon(
              onPressed: _onSendButtonClick,
              style: buttonStyle,
              label: const Text('Send file'),
              icon: const Icon(Icons.file_open),
            ),
            const SizedBox(
              width: 12,
            ),
            FilledButton.icon(
              onPressed: null,
              style: buttonStyle,
              label: Text('Send folder'),
              icon: Icon(Icons.folder_open),
            ),
          ],
        ),
        if (code != '') Card(
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
      ],
    ));
  }

  void _onSendButtonClick() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result != null) {
      final files = result.files.where((element) => element.path != null).toList().first;

      final stream = api.sendFile(fileName: files.name, filePath: files.path ?? '', codeLength: 3);

      stream.listen((e) {
        switch (e.event) {
          case Events.Code:
            setState(() {
              code = e.getValue().toString();
            });
            break;
          default:
        }
      });
    } else {
      debugPrint('user canceled picker');
    }
  }

  void _onSendFolderButtonClick() async {
    String? result = await FilePicker.platform.getDirectoryPath();

    if (result != null) {
    } else {
      debugPrint('user canceled picker');
    }
  }
}
