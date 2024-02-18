import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, 55, 0, 20),
          child: Text("Settings", style: TextStyle(fontSize: 40)),
        ),
        Gap(100),
        Center(
          child:  Text("Coming soon", style: TextStyle(fontSize: 23)),)
      ],
    ));
  }
}
