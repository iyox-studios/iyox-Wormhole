import 'package:flutter/material.dart';
import 'package:iyox_wormhole/pages/basePage.dart';

void main() => runApp(const WormholeApp());

class WormholeApp extends StatelessWidget {
  const WormholeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wormhole',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0x548F9F),
        brightness: Brightness.dark,
      ),
      home: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: const BasePage(),
      ),
    );
  }
}
