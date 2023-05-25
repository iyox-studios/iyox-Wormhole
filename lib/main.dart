import 'package:flutter/material.dart';
import 'package:wormhole/pages/basePage.dart';

void main() => runApp(const VocabularyApp());

class VocabularyApp extends StatelessWidget {
  const VocabularyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Womrhole',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0xff6750a4), brightness: Brightness.dark),
        home: const BasePage()
    );
  }
}