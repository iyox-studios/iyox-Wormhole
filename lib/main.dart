
import 'dart:io';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:iyox_wormhole/pages/router.dart';
import 'package:flutter/services.dart';
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
    initBackend();
    initApp().then((_) => debugPrint("App Init Completed"));
  }

  void initBackend() async {
    final tempDir = (await getTemporaryDirectory()).path;
    api.init(tempFilePath: tempDir);
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(builder: (lightColorScheme, darkColorScheme) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: darkColorScheme?.background,
          systemNavigationBarColor: darkColorScheme?.surface));
      return MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Wormhole',
        theme: ThemeData(
          colorScheme: lightColorScheme,
        ),
        darkTheme: ThemeData(
          colorScheme: darkColorScheme,
        ),
        themeMode: ThemeMode.dark,
        home: const BasePage(),
      );
    });
  }
}
