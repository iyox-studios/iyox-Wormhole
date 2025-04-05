import 'package:flutter/material.dart';
import 'package:iyox_wormhole/rust/api.dart' as rust_api;
import 'package:shared_preferences/shared_preferences.dart';

const String _kSettingThemeMode = 'setting_theme_mode';
const String _kSettingLanguage = 'setting_language';
const String _kSettingDynamicColor = 'setting_dynamic_color';
const String _kSettingAccentColor = 'setting_accent_color';
const String _kSettingRendezvousUrl = 'setting_rendezvous_url';
const String _kSettingTransitUrl = 'setting_transmit_url';
const String _kSettingCodeLength = 'setting_code_length';

class SharedPrefs {
  late final SharedPreferences _sharedPrefs;

  static final SharedPrefs _instance = SharedPrefs._internal();

  factory SharedPrefs() => _instance;

  SharedPrefs._internal();

  // Notifiers for reactive settings
  final ValueNotifier<ThemeMode> themeModeNotifier =
      ValueNotifier(ThemeMode.system);
  final ValueNotifier<String?> languageNotifier = ValueNotifier(null);
  final ValueNotifier<bool> dynamicColorNotifier = ValueNotifier(true);
  final ValueNotifier<Color> accentColorNotifier =
      ValueNotifier(Colors.blueGrey);

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();

    // Load reactive settings
    _loadThemeMode();
    _loadLanguage();
    _loadDynamicColor();
    _loadAccentColor();
  }

  // --- Theme Mode ---
  ThemeMode get themeMode {
    final themeString = _sharedPrefs.getString(_kSettingThemeMode);
    return ThemeMode.values.firstWhere(
      (e) => e.toString() == themeString,
      orElse: () => ThemeMode.system,
    );
  }

  set themeMode(ThemeMode value) {
    _sharedPrefs.setString(_kSettingThemeMode, value.toString());
    themeModeNotifier.value = value;
  }

  void _loadThemeMode() {
    themeModeNotifier.value = themeMode;
  }

  // --- Language ---
  String? get language {
    return _sharedPrefs
        .getString(_kSettingLanguage); // null means system default
  }

  set language(String? value) {
    if (value == null) {
      _sharedPrefs.remove(_kSettingLanguage);
      languageNotifier.value = null;
    } else {
      _sharedPrefs.setString(_kSettingLanguage, value);
      languageNotifier.value = value;
    }
  }

  void _loadLanguage() {
    languageNotifier.value = language;
  }

  // --- Dynamic Color ---
  bool get dynamicColor {
    return _sharedPrefs.getBool(_kSettingDynamicColor) ?? true;
  }

  set dynamicColor(bool value) {
    _sharedPrefs.setBool(_kSettingDynamicColor, value);
    dynamicColorNotifier.value = value;
  }

  void _loadDynamicColor() {
    dynamicColorNotifier.value = dynamicColor;
  }

  // --- Accent Color ---
  Color get accentColor {
    final colorValue = _sharedPrefs.getInt(_kSettingAccentColor);
    return colorValue != null ? Color(colorValue) : Colors.blueGrey;
  }

  set accentColor(Color value) {
    _sharedPrefs.setInt(_kSettingAccentColor, value.value);
    accentColorNotifier.value = value;
  }

  void _loadAccentColor() {
    accentColorNotifier.value = accentColor;
  }

  // --- Rendezvous URL ---
  String get rendezvousUrl {
    return _sharedPrefs.getString(_kSettingRendezvousUrl) ??
        rust_api.defaultRendezvousUrl();
  }

  set rendezvousUrl(String value) {
    _sharedPrefs.setString(_kSettingRendezvousUrl, value);
  }

  // --- Transit URL
  String get transitUrl {
    return _sharedPrefs.getString(_kSettingTransitUrl) ??
        rust_api.defaultTransitUrl();
  }

  set transitUrl(String value) {
    _sharedPrefs.setString(_kSettingTransitUrl, value);
  }

  // --- Code Length ---
  int get codeLength {
    return _sharedPrefs.getInt(_kSettingCodeLength) ?? 3;
  }

  set codeLength(int value) {
    _sharedPrefs.setInt(_kSettingCodeLength, value);
  }
}
