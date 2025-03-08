import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:iyox_wormhole/components/app_bar.dart';
import 'package:iyox_wormhole/i18n/strings.g.dart';
import 'package:iyox_wormhole/routing/router.dart';
import 'package:iyox_wormhole/themed_app.dart';
import 'package:iyox_wormhole/utils/device_info.dart';
import 'package:iyox_wormhole/utils/logger.dart';
import 'package:iyox_wormhole/utils/shared_prefs.dart';
import 'package:logger/logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Settings
  await SharedPrefs().init();

  // Display Mode
  if (kReleaseMode && Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }

  // Logging
  final logger = getLogger();
  if (kDebugMode) {
    Logger.level = Level.debug;
  } else {
    Logger.level = Level.warning;
  }

  FlutterError.onError = (details) {
    FlutterError.presentError(details);

    logger.f(
      'Uncaught Error: ${details.toString()} - ${details.exception}',
      error: details,
      stackTrace: details.stack,
    );
  };

  // Device Info
  await DeviceInfo().init();

  LocaleSettings.useDeviceLocale();
  runApp(TranslationProvider(child: const App()));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  //StreamSubscription? _intentDataStreamSubscription;

  @override
  void initState() {
    //setupSharingIntent();
    super.initState();
  }

  /*
  void setupSharingIntent() {
    if (Platform.isAndroid || Platform.isIOS) {
      // for files opened while the app is closed
      ReceiveSharingIntent.instance.getInitialMedia().then((List<SharedMediaFile> files) {
        for (final file in files) {
          App.openFile(file);
        }
      });

      // for files opened while the app is open
      final stream = ReceiveSharingIntent.instance.getMediaStream();
      _intentDataStreamSubscription = stream.listen((List<SharedMediaFile> files) {
        for (final file in files) {
          App.openFile(file);
        }
      });
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return ThemedApp(
      title: 'iyox Wormhole',
      router: goRouter,
    );
  }

  @override
  void dispose() {
    //_intentDataStreamSubscription?.cancel();
    super.dispose();
  }
}
