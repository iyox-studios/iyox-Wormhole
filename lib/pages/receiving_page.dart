import 'package:flutter/material.dart';
import 'package:iyox_wormhole/i18n/strings.g.dart';

class ReceivingPage extends StatefulWidget {
  const ReceivingPage({super.key, required this.code});

  final String code;

  @override
  State<ReceivingPage> createState() => _ReceivingPageState();
}

class _ReceivingPageState extends State<ReceivingPage> {
  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widget.code)
          ],
        ),
      ),
    );
  }
}
