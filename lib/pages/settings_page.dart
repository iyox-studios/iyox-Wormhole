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
  double _wordCountSlider = 0;
  int _wordCount = 0;

  static const int minWordCount = 1;
  static const int maxWordCount = 5;

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
                _wordCountSlider = snapshot.data!.toDouble();
                _wordCount = snapshot.data!;
                return FilledButton.tonal(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    shape: MaterialStateProperty.all(LinearBorder.none),
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.background),
                    textStyle: MaterialStateProperty.all(
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                                ),
                                Row(
                                  children: [

                                Text(
                                  _wordCount.toString(),
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                                ),
                                Expanded(
                                  child: Slider(
                                    value: _wordCountSlider.clamp(1, 5),
                                    min: minWordCount.toDouble(),
                                    max: maxWordCount.toDouble(),
                                    divisions: maxWordCount - minWordCount,
                                    label: _wordCount.toString(),
                                    onChanged: (double value) {
                                      setState(() {
                                        _wordCountSlider = value;
                                        if (_wordCountSlider.round() !=
                                            _wordCount) {
                                          _wordCount = _wordCountSlider.round();
                                          Settings.setWordLength(
                                              _wordCount.round());
                                        }
                                      });
                                    },
                                  ),
                                )])
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
