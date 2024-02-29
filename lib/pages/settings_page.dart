import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iyox_wormhole/utils/settings.dart';
import 'package:iyox_wormhole/widgets/settings_field.dart';
import 'package:iyox_wormhole/widgets/settings_header.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.fromLTRB(20, 55, 0, 0),
            child: Text("Settings", style: TextStyle(fontSize: 37))),
        const Gap(5),
        const SettingsHeader("Security"),
        FutureBuilder(
            future: Settings.getWordLength(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SettingField(
                  title: "Word count",
                  initialValue: snapshot.data.toString(),
                  onSubmit: (value) => setState(() {
                    Settings.setWordLength(int.tryParse(value));
                  }),
                );
              }
              return const SizedBox(
                width: 0.0,
                height: 0.0,
              );
            }),
        const SettingsHeader("Connection"),
        FutureBuilder(
            future: Settings.getRendezvousUrl(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SettingField(
                  title: "Rendezvous URL",
                  initialValue: snapshot.data.toString(),
                  onSubmit: (value) => setState(() {
                    Settings.setRendezvousUrl(value);
                  }),
                );
              }
              return const SizedBox(
                width: 0.0,
                height: 0.0,
              );
            }),
        FutureBuilder(
            future: Settings.getTransitUrl(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return SettingField(
                  title: "Transit URL",
                  initialValue: snapshot.data.toString(),
                  onSubmit: (value) => setState(() {
                    Settings.setTransitUrl(value);
                  }),
                );
              }
              return const SizedBox(
                width: 0.0,
                height: 0.0,
              );
            }),
      ],
    );
  }
}
