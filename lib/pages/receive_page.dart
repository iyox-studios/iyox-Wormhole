import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iyox_wormhole/i18n/strings.g.dart';
import 'package:iyox_wormhole/widgets/app_bar.dart';
import 'package:iyox_wormhole/widgets/illustration.dart';

class ReceivePage extends StatefulWidget {
  const ReceivePage({super.key});

  @override
  State<ReceivePage> createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: t.common.page_titles.receive,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Illustration(
                assetPath: 'assets/illustrations/undraw_file-manager_yics.svg',
                label: 'Download illustration',
                width: 270,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
