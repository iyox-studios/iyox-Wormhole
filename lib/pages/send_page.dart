import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iyox_wormhole/i18n/strings.g.dart';
import 'package:iyox_wormhole/utils/logger.dart';
import 'package:iyox_wormhole/widgets/app_bar.dart';
import 'package:iyox_wormhole/widgets/illustration.dart';
import 'package:iyox_wormhole/widgets/large_icon_button.dart';
import 'package:permission_handler/permission_handler.dart';

class SendPage extends StatefulWidget {
  const SendPage({super.key});

  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  final log = getLogger();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: t.common.page_titles.send,
      ),
      body: Stack(
        children: [
          Center(
            child: Illustration(
                label: 'Upload illustration',
                assetPath: 'assets/illustrations/undraw_upload_cucu.svg',
                width: 270),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: LargeIconButton(
                      onPressed: _onSendButtonClick,
                      label: Text(t.pages.send.send_file),
                      icon: Icons.file_open,
                    ),
                  ),
                  SizedBox(width: 22.0),
                  Expanded(
                    child: LargeIconButton(
                      onPressed: _onSendFolderButtonClick,
                      label: Text(t.pages.send.send_folder),
                      icon: Icons.drive_folder_upload,
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
      }
    }
  }

  void _onSendFolderButtonClick() async {
    try {
      final permissionStatus = await Permission.manageExternalStorage.request();
      if (!permissionStatus.isGranted) {
        if (mounted) {
          final t = Translations.of(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(t.pages.send.permission_denied),
              duration: Duration(seconds: 2),
            ),
          );
        }
        return;
      }
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
    }
  }
}
