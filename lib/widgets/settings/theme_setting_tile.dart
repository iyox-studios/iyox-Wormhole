import 'package:flutter/material.dart';
import 'package:iyox_wormhole/i18n/strings.g.dart';
import 'package:iyox_wormhole/utils/shared_prefs.dart';
import 'package:iyox_wormhole/widgets/settings/radio_selection_dialog.dart';

class ThemeSettingTile extends StatefulWidget {
  const ThemeSettingTile({super.key});

  @override
  State<ThemeSettingTile> createState() => _ThemeSettingTileState();
}

class _ThemeSettingTileState extends State<ThemeSettingTile> {
  final _prefs = SharedPrefs();

  String _themeModeToString(ThemeMode mode, Translations t) {
    switch (mode) {
      case ThemeMode.system:
        return t.pages.settings.theme_system;
      case ThemeMode.light:
        return t.pages.settings.theme_light;
      case ThemeMode.dark:
        return t.pages.settings.theme_dark;
    }
  }

  Future<void> _showThemeDialog(BuildContext context, Translations t) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return RadioSelectionDialog<ThemeMode>(
          title: t.pages.settings.theme_label,
          currentValue: _prefs.themeMode,
          options: ThemeMode.values.map((mode) {
            return RadioOption(value: mode, title: _themeModeToString(mode, t));
          }).toList(),
          onChanged: (ThemeMode? value) {
            if (value != null) {
              _prefs.themeMode = value;
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _prefs.themeModeNotifier,
      builder: (context, currentMode, child) {
        return ListTile(
          leading: const Icon(Icons.brightness_6),
          title: Text(t.pages.settings.theme_label),
          subtitle: Text(_themeModeToString(currentMode, t)),
          onTap: () async => _showThemeDialog(context, t),
        );
      },
    );
  }
}
