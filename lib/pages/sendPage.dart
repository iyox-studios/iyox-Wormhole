import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iyox_wormhole/type_helpers.dart';

import '../gen/ffi.dart';

class SendPage extends StatefulWidget {
  const SendPage({Key? key}) : super(key: key);

  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {

  String code = '';

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton.extended(
              onPressed: _onSendButtonClick,
              label: const Text('Send file'),
              icon: const Icon(Icons.file_open),
            ),
            const SizedBox(
              width: 12,
            ),
            const FloatingActionButton.extended(
              onPressed: null,
              label: Text('Send folder'),
              icon: Icon(Icons.folder_open),
            ),
          ],
        ),
        if(code!='') Text(style: Theme.of(context).textTheme.titleMedium, code),
      ],
    ));
  }

  void _onSendButtonClick() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result != null) {
      final files = result.files.where((element) => element.path != null).toList().first;

      final stream = api.sendFile(fileName: files.name, filePath: files.path ?? '', codeLength: 3);

      stream.listen((e) {
        debugPrint(e.event.toString() + ' ' + e.value.toString());
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
