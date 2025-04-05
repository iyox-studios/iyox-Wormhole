import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:iyox_wormhole/i18n/strings.g.dart';
import 'package:iyox_wormhole/routing/router.dart';
import 'package:iyox_wormhole/rust/api.dart';
import 'package:iyox_wormhole/rust/frb_generated.dart';
import 'package:iyox_wormhole/themed_app.dart';
import 'package:iyox_wormhole/utils/device_info.dart';
import 'package:iyox_wormhole/utils/logger.dart';
import 'package:iyox_wormhole/utils/shared_prefs.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await RustLib.init();
  final tempDir = (await getTemporaryDirectory()).path;
  initBackend(tempFilePath: tempDir);

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

  // Set initial locale from saved preferences or device settings
  final prefs = SharedPrefs();
  final savedLocale = prefs.language;
  if (savedLocale != null &&
      AppLocaleUtils.supportedLocales
          .any((l) => l.languageCode == savedLocale)) {
    await LocaleSettings.setLocale(AppLocaleUtils.parse(savedLocale));
  } else {
    await LocaleSettings.useDeviceLocale();
  }

  runApp(TranslationProvider(child: const App()));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  StreamSubscription<List<SharedMediaFile>>? _intentDataStreamSubscription;

  @override
  void initState() {
    setupSharingIntent();
    super.initState();
  }

  void setupSharingIntent() {
    if (Platform.isAndroid || Platform.isIOS) {
      // for files opened while the app is closed
      unawaited(ReceiveSharingIntent.instance
          .getInitialMedia()
          .then((List<SharedMediaFile> files) {
        if (files.isNotEmpty) {
          if (mounted) {
            goRouter.go('/send/sending', extra: {
              'files': files.map((file) => file.path).toList(),
              'isFolder': false,
              'launchedByIntent': true
            });
          }
        }

        ReceiveSharingIntent.instance.reset();
      }));

      // for files opened while the app is open
      final stream = ReceiveSharingIntent.instance.getMediaStream();
      _intentDataStreamSubscription =
          stream.listen((List<SharedMediaFile> files) {
        if (files.isNotEmpty) {
          if (mounted) {
            goRouter.go('/send/sending', extra: {
              'files': files.map((file) => file.path).toList(),
              'isFolder': false,
              'launchedByIntent': true
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ThemedApp(
      title: 'iyox Wormhole',
      router: goRouter,
    );
  }

  @override
  void dispose() {
    _intentDataStreamSubscription?.cancel();
    super.dispose();
  }
}
