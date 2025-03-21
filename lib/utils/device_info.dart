import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  DeviceInfo._internal();

  factory DeviceInfo() => _instance;
  static final _instance = DeviceInfo._internal();

  late final BaseDeviceInfo deviceInfo;

  Future<void> init() async {
    final plugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      deviceInfo = await plugin.androidInfo;
    } else if (Platform.isLinux) {
      deviceInfo = await plugin.linuxInfo;
    }
  }

  bool get supportsDynamicColor {
    final info = deviceInfo;
    return switch (info) {
      AndroidDeviceInfo() => info.version.sdkInt >= 31,
      _ => false,
    };
  }
}
