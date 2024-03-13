import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../gen/ffi.dart';

class Defaults {
  static int get wordLength => 2;
}

class Settings {
  static const _wordLength = 'WORD_LENGTH';
  static const _rendezvousUrl = 'RENDEZVOUS_URL';
  static const _transitUrl = 'TRANSIT_URL';
  static const _recentFiles = 'RECENT_FILES';
  static const _themeMode = 'THEME_MODE';

  static Future<void> setWordLength(int? value) async {
    await _setField(value, _wordLength);
  }

  static Future<void> setRendezvousUrl(String? value) async {
    await _setField(value, _rendezvousUrl);
  }

  static Future<void> setTransitUrl(String? value) async {
    await _setField(value, _transitUrl);
  }

  static Future<void> setRecentFiles(List<String>? value) async {
    await _setField(value, _recentFiles);
  }

  static Future<void> addRecentFile(String value) async {
    var recentFiles = await getRecentFiles();
    recentFiles.add(value);

    if(recentFiles.contains(value)){
      recentFiles.removeWhere((item) => item == value);
      recentFiles.add(value);
    }
    if(recentFiles.length>10){
      recentFiles = recentFiles.getRange(recentFiles.length-11, recentFiles.length-1).toList();
    }
    debugPrint(recentFiles.length.toString());

    await _setField(recentFiles, _recentFiles);
  }

  static Future<void> setThemeMode(ThemeMode value) async {
    await _setField(value.toString(), _themeMode);
  }

  static Future<int> getWordLength() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_wordLength) ?? 3;
  }

  static Future<String> getRendezvousUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_rendezvousUrl) ?? await api.defaultRendezvousUrl();
  }

  static Future<String> getTransitUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_transitUrl) ?? await api.defaultTransitUrl();
  }

  static Future<List<String>> getRecentFiles() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_recentFiles) ?? [];
  }

  static Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString(_themeMode) ?? 'ThemeMode.system';
    return ThemeMode.values.firstWhere((e) => e.toString() == themeModeString);
  }

  static _setField<T>(T? value, String field) async {
    final prefs = await SharedPreferences.getInstance();
    if (value == null) {
      await prefs.remove(field);
    } else {
      if (value is int) {
        await prefs.setInt(field, value);
      } else if (value is bool) {
        await prefs.setBool(field, value);
      } else if (value is String) {
        await prefs.setString(field, value);
      } else if (value is List<String>) {
        await prefs.setStringList(field, value);
      }
    }
  }
}
