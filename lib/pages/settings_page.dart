import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:iyox_wormhole/i18n/strings.g.dart';
import 'package:iyox_wormhole/rust/api.dart';
import 'package:iyox_wormhole/utils/device_info.dart';
import 'package:iyox_wormhole/utils/shared_prefs.dart';
import 'package:iyox_wormhole/widgets/app_bar.dart';
import 'package:iyox_wormhole/widgets/settings/language_setting_tile.dart';
import 'package:iyox_wormhole/widgets/settings/settings_header.dart';
import 'package:iyox_wormhole/widgets/settings/slider_setting.dart';
import 'package:iyox_wormhole/widgets/settings/theme_setting_tile.dart';
import 'package:iyox_wormhole/widgets/settings/url_setting_field.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _prefs = SharedPrefs();
  final _deviceInfo = DeviceInfo();

  late String _defaultRendezvousUrl;
  late String _defaultTransmitUrl;
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();

    _defaultRendezvousUrl = defaultRendezvousUrl();
    _defaultTransmitUrl = defaultTransitUrl();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  Future<void> _showColorPickerDialog() async {
    final t = Translations.of(context);
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(t.pages.settings.accent_color_label),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: _prefs.accentColor,
              onColorChanged: (color) {
                _prefs.accentColor = color;
              },
              availableColors: const [
                Colors.red,
                Colors.pink,
                Colors.purple,
                Colors.deepPurple,
                Colors.indigo,
                Colors.blue,
                Colors.lightBlue,
                Colors.cyan,
                Colors.teal,
                Colors.green,
                Colors.lightGreen,
                Colors.lime,
                Colors.yellow,
                Colors.amber,
                Colors.orange,
                Colors.deepOrange,
                Colors.brown,
                Colors.grey,
                Colors.blueGrey,
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(t.common.generic_acknowledge),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: t.common.page_titles.settings,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        children: [
          SettingsHeader(t.pages.settings.appearance_header),

          const LanguageSettingTile(),

          const ThemeSettingTile(),

          ValueListenableBuilder<bool>(
            valueListenable: _prefs.dynamicColorNotifier,
            builder: (context, isDynamic, child) {
              final bool supportsDynamicColor = _deviceInfo.supportsDynamicColor;
              final bool dynamicColorEffectivelyEnabled = isDynamic && supportsDynamicColor;

              return Column(
                children: [
                  SwitchListTile(
                    secondary: const Icon(Icons.color_lens_outlined),
                    title: Text(t.pages.settings.dynamic_color_label),
                    subtitle: Text(t.pages.settings.dynamic_color_subtitle),
                    value: dynamicColorEffectivelyEnabled,
                    onChanged: supportsDynamicColor
                        ? (bool value) {
                            _prefs.dynamicColor = value;
                          }
                        : null,
                  ),
                  if (!dynamicColorEffectivelyEnabled)
                    ValueListenableBuilder<Color>(
                      valueListenable: _prefs.accentColorNotifier,
                      builder: (context, currentColor, child) {
                        return ListTile(
                          leading: const Icon(Icons.palette_outlined),
                          title: Text(t.pages.settings.accent_color_label),
                          trailing: CircleAvatar(
                            backgroundColor: currentColor,
                            radius: 14,
                          ),
                          onTap: _showColorPickerDialog,
                        );
                      },
                    ),
                ],
              );
            },
          ),

          SettingsHeader(t.pages.settings.connection_header),

          UrlSettingField(
            label: t.pages.settings.rendezvous_url_label,
            icon: Icons.public,
            initialValue: _prefs.rendezvousUrl,
            defaultValue: _defaultRendezvousUrl,
            onSave: (value) => _prefs.rendezvousUrl = value,
            resetTooltip: t.pages.settings.reset_to_default,
          ),

          UrlSettingField(
            label: t.pages.settings.transmit_url_label,
            icon: Icons.cloud_upload_outlined,
            initialValue: _prefs.transitUrl,
            defaultValue: _defaultTransmitUrl,
            onSave: (value) => _prefs.transitUrl = value,
            resetTooltip: t.pages.settings.reset_to_default,
          ),

          SliderSetting(
            label: t.pages.settings.code_length_label,
            icon: Icons.pin_outlined,
            min: 2.0,
            max: 8.0,
            divisions: 6,
            initialValue: _prefs.codeLength,
            onSave: (value) => _prefs.codeLength = value,
          ),

          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(t.pages.settings.app_version_label),
            subtitle: Text(_packageInfo.version),
          ),
        ],
      ),
    );
  }
}
