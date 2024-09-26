import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:iyox_wormhole/pages/router.dart';
import 'package:iyox_wormhole/utils/settings.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

import 'gen/ffi.dart';
import 'themed_app.dart';

void main() async {
  await initApp();
  runApp(const WormholeApp());
}

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kReleaseMode && Platform.isAndroid) {
    try {
      await FlutterDisplayMode.setHighRefreshRate();
      debugPrint("Enabled high refresh mode");
    } catch (e) {
      debugPrint("Error setting high refresh rate: $e");
    }
  }

  var log = Logger();

  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    log.f(
      'FlutterError - Catch all error: ${details.toString()} - ${details.exception} - ${details.library} - ${details.context} - ${details.stack}',
      error: details,
      stackTrace: details.stack,
    );
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    log.f('PlatformDispatcher - Catch all error: $error', error: error, stackTrace: stack);
    debugPrint("PlatformDispatcher - Catch all error: $error $stack");
    return true;
  };
}

class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

class WormholeApp extends StatefulWidget {
  const WormholeApp({super.key});

  @override
  WormholeAppState createState() => WormholeAppState();
}

class WormholeAppState extends State<WormholeApp> {
  Future<void> initApp() async {
    // Clear Cache
    await FilePicker.platform.clearTemporaryFiles();
    await Settings.setRecentFiles([]);
  }

  @override
  initState() {
    super.initState();
    initBackend();
    initApp().then((_) => debugPrint("App Init Completed"));
  }

  @override
  Future<void> dispose() async {
    super.dispose();
  }

  void initBackend() async {
    final tempDir = (await getTemporaryDirectory()).path;
    api.init(tempFilePath: tempDir);
  }

  @override
  Widget build(BuildContext context) {
    return ThemedApp(
      builder: (lightScheme, darkScheme, isDarkMode) => MaterialApp(
        theme: ThemeData(colorScheme: lightScheme, useMaterial3: true),
        darkTheme: ThemeData(colorScheme: darkScheme, useMaterial3: true),
        debugShowCheckedModeBanner: false,
        title: 'Wormhole',
        home: const BasePage(),
      ),
    );
  }
}
