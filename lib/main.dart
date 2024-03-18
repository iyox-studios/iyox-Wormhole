import 'dart:io';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:iyox_wormhole/pages/router.dart';
import 'package:flutter/services.dart';
import 'package:iyox_wormhole/utils/settings.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

import 'gen/ffi.dart';

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
    log.f('PlatformDispatcher - Catch all error: $error',
        error: error, stackTrace: stack);
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

class WormholeAppState extends State<WormholeApp> with WidgetsBindingObserver {
  ThemeMode themeMode = ThemeMode.dark;

  Future<void> initApp() async {
    // Draw the app from edge to edge
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    // Sets the navigation bar color
    SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
    );
    SystemChrome.setSystemUIOverlayStyle(overlayStyle);
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initBackend();
    initApp().then((_) => debugPrint("App Init Completed"));

    var brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    getCurrentAppTheme().then((value) {
      setState(() {
        if (value == ThemeMode.system) {
          themeMode =
              brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
        } else {
          themeMode = value;
        }
      });
    });
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    await FilePicker.platform.clearTemporaryFiles();
    await Settings.setRecentFiles([]);
    debugPrint("closing app");
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();

    setTheme();
  }

  Future<ThemeMode> getCurrentAppTheme() async {
    return await Settings.getThemeMode();
  }

  void setTheme() {
    var brightness = View.of(context).platformDispatcher.platformBrightness;
    getCurrentAppTheme().then((value) {
      debugPrint(value.toString());

      setState(() {
        if (value == ThemeMode.system) {
          themeMode =
          brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
        } else {
          themeMode = value;
        }
      });
    });
  }

  void initBackend() async {
    final tempDir = (await getTemporaryDirectory()).path;
    api.init(tempFilePath: tempDir);
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      var lightScheme = lightColorScheme ?? ColorScheme.fromSeed(seedColor:Colors.indigo, brightness: Brightness.light);
      var darkScheme = darkColorScheme ?? ColorScheme.fromSeed(seedColor:Colors.indigo, brightness: Brightness.dark);
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: themeMode == ThemeMode.dark
              ? darkScheme.background
              : lightScheme.background,
          systemNavigationBarColor: themeMode == ThemeMode.dark
              ? darkScheme.surface
              : lightScheme.surface));
      return MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Wormhole',
        theme: ThemeData(
          colorScheme: lightScheme,
        ),
        darkTheme: ThemeData(
          colorScheme: darkScheme,
        ),
        themeMode: themeMode,
        home: const BasePage(),
      );
    });
  }
}
