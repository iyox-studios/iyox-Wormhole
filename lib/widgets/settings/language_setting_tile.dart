import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:iyox_wormhole/i18n/strings.g.dart';
import 'package:iyox_wormhole/utils/shared_prefs.dart';
import 'package:iyox_wormhole/widgets/settings/radio_selection_dialog.dart';

class LanguageSettingTile extends StatefulWidget {
  const LanguageSettingTile({super.key});

  @override
  State<LanguageSettingTile> createState() => _LanguageSettingTileState();
}

class _LanguageSettingTileState extends State<LanguageSettingTile> {
  final _prefs = SharedPrefs();

  Future<void> _handleLanguageChange(String? newLangCode) async {
    _prefs.language = newLangCode;
    if (newLangCode != null) {
      await LocaleSettings.setLocale(AppLocaleUtils.parse(newLangCode));
    } else {
      await LocaleSettings.useDeviceLocale();
    }
  }

  Future<void> _showLanguageDialog(BuildContext context, String? currentLangCode) async {
    final t = Translations.of(context);
    final languageOptions = [
      RadioOption(value: null, title: t.pages.settings.language_system),
      ...AppLocale.values.map((locale) =>
          RadioOption(value: locale.languageCode, title: getNativeLocalName(locale.languageCode)))
    ];

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return RadioSelectionDialog<String?>(
          title: t.pages.settings.language_label,
          currentValue: currentLangCode,
          options: languageOptions,
          onChanged: (value) async {
            await _handleLanguageChange(value);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return ValueListenableBuilder<String?>(
      valueListenable: _prefs.languageNotifier,
      builder: (context, currentLangCode, child) {
        String currentLanguageDisplay;
        if (currentLangCode == null) {
          currentLanguageDisplay = t.pages.settings.language_system;
        } else {
          currentLanguageDisplay = getNativeLocalName(currentLangCode);
        }

        return ListTile(
          leading: Icon(Icons.translate),
          title: Text(t.pages.settings.language_label),
          subtitle: Text(currentLanguageDisplay),
          onTap: () async => _showLanguageDialog(context, currentLangCode),
        );
      },
    );
  }

  String getNativeLocalName(String localeCode) {
    return LocaleNamesLocalizationsDelegate.nativeLocaleNames[localeCode] ?? localeCode;
  }
}
