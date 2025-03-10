import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iyox_wormhole/components/app_bar.dart';
import 'package:iyox_wormhole/i18n/strings.g.dart';
import 'package:iyox_wormhole/utils/logger.dart';
import 'package:permission_handler/permission_handler.dart';

class SendPage extends StatefulWidget {
  const SendPage({super.key});

  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  final log = getLogger();

  static final ButtonStyle buttonStyle = ButtonStyle(
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(200),
      ),
    ),
    fixedSize: WidgetStateProperty.all<Size>(Size.fromHeight(65)),
  );

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: t.common.page_titles.send,
      ),
      body: Stack(
        children: [
          // Your main content
          Center(child: Text("Your main content goes here")),
          // Align buttons at the bottom center
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _onSendButtonClick,
                      style: buttonStyle,
                      label: Text(t.pages.send.send_file),
                      icon: const Icon(Icons.file_open),
                    ),
                  ),
                  SizedBox(width: 22.0),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _onSendFolderButtonClick,
                      style: buttonStyle,
                      label: Text(t.pages.send.send_folder),
                      icon: const Icon(Icons.drive_folder_upload),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSendButtonClick() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (mounted) {
      if (result != null) {
        final files = result.files
            .where((element) => element.path != null)
            .map((e) => e.path!)
            .toList();

        context.go('/send/sending', extra: {'files': files, 'isFolder': false});
        //Navigator.push(context, _createSendingRoute(files));
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

  void _onSendFolderButtonClick() async {
      try {
        await Permission.manageExternalStorage.request();
      } catch (e) {
        log.w('Failed to request manageExternalStorage permission', error: e);
      }


    String? path = await FilePicker.platform.getDirectoryPath();

    if (path != null) {

      if (mounted) {
        context.go('/send/sending', extra: {
          'files': [path],
          'isFolder': true
        });
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('No folder selected'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
