import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iyox_wormhole/i18n/strings.g.dart';
import 'package:iyox_wormhole/utils/logger.dart';
import 'package:iyox_wormhole/widgets/app_bar.dart';
import 'package:iyox_wormhole/widgets/illustration.dart';
import 'package:iyox_wormhole/widgets/large_icon_button.dart';
import 'package:pick_or_save/pick_or_save.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Center(
              child: Illustration(
                  label: 'Upload illustration',
                  assetPath: 'assets/illustrations/undraw_upload_cucu.svg',
                  width: 270),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                constraints: BoxConstraints(maxWidth: 450),
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
      ),
    );
  }

  void _onSendButtonClick() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      if (mounted) {
        final files =
            result.files.where((element) => element.path != null).map((e) => e.path!).toList();

        context.go('/send/sending', extra: {'files': files, 'isFolder': false});
      }
    }
  }

  void _onSendFolderButtonClick() async {
    String? path = await PickOrSave().directoryPicker();

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
