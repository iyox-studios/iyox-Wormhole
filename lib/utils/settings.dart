import 'package:shared_preferences/shared_preferences.dart';

import '../gen/ffi.dart';

class Defaults {
  static int get wordLength => 2;
}

class Settings {
  static const _wordLength = 'WORD_LENGTH';
  static const _rendezvousUrl = 'RENDEZVOUS_URL';
  static const _transitUrl = 'TRANSIT_URL';

  static setWordLength(int? value) async {
    await _setField(value, _wordLength);
  }

  static setRendezvousUrl(String? value) async {
    await _setField(value, _rendezvousUrl);
  }

  static setTransitUrl(String? value) async {
    await _setField(value, _transitUrl);
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
      }
    }
  }
}
