import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icons_launcher/cli_commands.dart';
import 'package:iyox_wormhole/utils/settings.dart';
import 'package:iyox_wormhole/widgets/settings_field.dart';
import 'package:iyox_wormhole/widgets/settings_header.dart';
import 'package:restart_app/restart_app.dart';

import '../gen/ffi.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double _wordCountSlider = 0;
  int _wordCount = 0;

  static const int minWordCount = 1;
  static const int maxWordCount = 8;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 55, 0, 0),
            child: Text("Settings", style: TextStyle(fontSize: 37)),
          ),
          const Gap(5),
          const SettingsHeader("Security"),
          FutureBuilder(
              future: Settings.getWordLength(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _wordCountSlider = snapshot.data!.toDouble();
                  _wordCount = snapshot.data!;
                  return FilledButton.tonal(
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                      shape: WidgetStateProperty.all(LinearBorder.none),
                      backgroundColor:
                          WidgetStateProperty.all(Theme.of(context).colorScheme.surface),
                      textStyle: WidgetStateProperty.all(
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    onPressed: () => {},
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 17, 20, 5),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Word Count",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context).colorScheme.onSurface),
                                  ),
                                  Row(children: [
                                    Text(
                                      _wordCount.toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Theme.of(context).colorScheme.onSurface),
                                    ),
                                    Expanded(
                                      child: Slider(
                                        value: _wordCountSlider.clamp(
                                            minWordCount.toDouble(), maxWordCount.toDouble()),
                                        min: minWordCount.toDouble(),
                                        max: maxWordCount.toDouble(),
                                        divisions: maxWordCount - minWordCount,
                                        label: _wordCount.toString(),
                                        onChanged: (double value) {
                                          setState(() {
                                            _wordCountSlider = value;
                                            if (_wordCountSlider.round() != _wordCount) {
                                              _wordCount = _wordCountSlider.round();
                                              Settings.setWordLength(_wordCount.round());
                                            }
                                          });
                                        },
                                      ),
                                    )
                                  ])
                                ]))),
                  );
                }
                return const SizedBox(
                  width: 0.0,
                  height: 0.0,
                );
              }),
          const SettingsHeader("Appearance"),
          FutureBuilder(
              future: Settings.getThemeMode(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return FilledButton.tonal(
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                      shape: WidgetStateProperty.all(LinearBorder.none),
                      backgroundColor:
                          WidgetStateProperty.all(Theme.of(context).colorScheme.surface),
                      textStyle: WidgetStateProperty.all(
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            ThemeMode theme = snapshot.data!;
                            return StatefulBuilder(builder: (context, setState) {
                              return AlertDialog(
                                  title: const Text("Theme"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      for (var value in ThemeMode.values)
                                        RadioListTile(
                                            title:
                                                Text(value.toString().split('.').last.capitalize()),
                                            value: value,
                                            groupValue: theme,
                                            onChanged: (value) {
                                              setState(() {
                                                theme = value!;
                                              });
                                            }),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        textStyle: Theme.of(context).textTheme.labelLarge,
                                      ),
                                      child: const Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        textStyle: Theme.of(context).textTheme.labelLarge,
                                      ),
                                      child: const Text('Save'),
                                      onPressed: () {
                                        this.setState(() {
                                          Settings.setThemeMode(theme)
                                              .then((_) => Restart.restartApp());
                                        });
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ]);
                            });
                          });
                    },
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 17, 20, 5),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Theme",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Theme.of(context).colorScheme.onSurface),
                                  ),
                                  Text(
                                    snapshot.data!.toString().split('.').last.capitalize(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context).colorScheme.onSurface),
                                  )
                                ]))),
                  );
                }
                return const SizedBox(
                  width: 0.0,
                  height: 0.0,
                );
              }),
          const SettingsHeader("Connection"),
          FutureBuilder(
              future: Future.wait([Settings.getRendezvousUrl(), api.defaultRendezvousUrl()]),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SettingField(
                    title: "Rendezvous URL",
                    defaultValue: snapshot.data![1].toString(),
                    initialValue: snapshot.data![0].toString() == snapshot.data![1].toString()
                        ? ''
                        : snapshot.data![0].toString(),
                    onSubmit: (value) => setState(() {
                      Settings.setRendezvousUrl(value == '' ? snapshot.data![1].toString() : value);
                    }),
                  );
                }
                return const SizedBox(
                  width: 0.0,
                  height: 0.0,
                );
              }),
          FutureBuilder(
              future: Future.wait([Settings.getTransitUrl(), api.defaultTransitUrl()]),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SettingField(
                    title: "Transit URL",
                    defaultValue: snapshot.data![1].toString(),
                    initialValue: snapshot.data![0].toString() == snapshot.data![1].toString()
                        ? ''
                        : snapshot.data![0].toString(),
                    onSubmit: (value) => setState(() {
                      Settings.setTransitUrl(value == '' ? snapshot.data![1].toString() : value);
                    }),
                  );
                }
                return const SizedBox(
                  width: 0.0,
                  height: 0.0,
                );
              }),
        ],
      )
    ]);
  }
}
