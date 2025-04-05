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
          content: _ColorPickerDialogContent(
            prefs: _prefs,
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
          _AppearanceSettingsSection(
            prefs: _prefs,
            deviceInfo: _deviceInfo,
            onShowColorPicker: _showColorPickerDialog,
          ),
          _ConnectionSettingsSection(
            prefs: _prefs,
            defaultRendezvousUrl: _defaultRendezvousUrl,
            defaultTransmitUrl: _defaultTransmitUrl,
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

class _AppearanceSettingsSection extends StatelessWidget {
  final SharedPrefs prefs;
  final DeviceInfo deviceInfo;
  final VoidCallback onShowColorPicker;

  const _AppearanceSettingsSection({
    required this.prefs,
    required this.deviceInfo,
    required this.onShowColorPicker,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsHeader(t.pages.settings.appearance_header),
        const LanguageSettingTile(),
        const ThemeSettingTile(),
        ValueListenableBuilder<bool>(
          valueListenable: prefs.dynamicColorNotifier,
          builder: (context, isDynamic, child) {
            final bool supportsDynamicColor = deviceInfo.supportsDynamicColor;
            final bool dynamicColorEffectivelyEnabled =
                isDynamic && supportsDynamicColor;

            return Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.color_lens_outlined),
                  title: Text(t.pages.settings.dynamic_color_label),
                  subtitle: Text(t.pages.settings.dynamic_color_subtitle),
                  value: dynamicColorEffectivelyEnabled,
                  onChanged: supportsDynamicColor
                      ? (bool value) {
                          prefs.dynamicColor = value;
                        }
                      : null,
                ),
                if (!dynamicColorEffectivelyEnabled)
                  ValueListenableBuilder<Color>(
                    valueListenable: prefs.accentColorNotifier,
                    builder: (context, currentColor, child) {
                      return ListTile(
                        leading: const Icon(Icons.palette_outlined),
                        title: Text(t.pages.settings.accent_color_label),
                        trailing: CircleAvatar(
                          backgroundColor: currentColor,
                          radius: 14,
                        ),
                        onTap: onShowColorPicker,
                      );
                    },
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _ConnectionSettingsSection extends StatelessWidget {
  final SharedPrefs prefs;
  final String defaultRendezvousUrl;
  final String defaultTransmitUrl;

  const _ConnectionSettingsSection({
    required this.prefs,
    required this.defaultRendezvousUrl,
    required this.defaultTransmitUrl,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsHeader(t.pages.settings.connection_header),
        UrlSettingField(
          label: t.pages.settings.rendezvous_url_label,
          icon: Icons.public,
          initialValue: prefs.rendezvousUrl,
          defaultValue: defaultRendezvousUrl,
          onSave: (value) => prefs.rendezvousUrl = value,
          resetTooltip: t.pages.settings.reset_to_default,
        ),
        UrlSettingField(
          label: t.pages.settings.transmit_url_label,
          icon: Icons.cloud_upload_outlined,
          initialValue: prefs.transitUrl,
          defaultValue: defaultTransmitUrl,
          onSave: (value) => prefs.transitUrl = value,
          resetTooltip: t.pages.settings.reset_to_default,
        ),
        SliderSetting(
          label: t.pages.settings.code_length_label,
          icon: Icons.pin_outlined,
          min: 2.0,
          max: 8.0,
          divisions: 6,
          initialValue: prefs.codeLength,
          onSave: (value) => prefs.codeLength = value,
        ),
      ],
    );
  }
}

class _ColorPickerDialogContent extends StatelessWidget {
  final SharedPrefs prefs;

  const _ColorPickerDialogContent({required this.prefs});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlockPicker(
        pickerColor: prefs.accentColor,
        onColorChanged: (color) {
          prefs.accentColor = color;
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
    );
  }
}
