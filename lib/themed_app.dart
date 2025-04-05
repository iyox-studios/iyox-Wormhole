import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:iyox_wormhole/i18n/strings.g.dart';
import 'package:iyox_wormhole/utils/device_info.dart';
import 'package:iyox_wormhole/utils/shared_prefs.dart';

class ThemedApp extends StatefulWidget {
  const ThemedApp({
    super.key,
    required this.title,
    required this.router,
    this.defaultSwatch = Colors.yellow,
  });

  final String title;
  final Color defaultSwatch;
  final GoRouter router;

  static final ValueNotifier<bool> _isFullscreen = ValueNotifier(false);

  static bool get isFullscreen => _isFullscreen.value;

  static Future<void> setFullscreen(bool value,
      {required bool updateSystem}) async {
    _isFullscreen.value = value;
    if (!updateSystem) return;

    await SystemChrome.setEnabledSystemUIMode(
        value ? SystemUiMode.immersive : SystemUiMode.edgeToEdge);
  }

  static void addFullscreenListener(void Function() listener) {
    _isFullscreen.addListener(listener);
  }

  static void removeFullscreenListener(void Function() listener) {
    _isFullscreen.removeListener(listener);
  }

  @override
  State<ThemedApp> createState() => _ThemedAppState();
}

class _ThemedAppState extends State<ThemedApp> {
  final DeviceInfo deviceInfo = DeviceInfo();
  final SharedPrefs _prefs = SharedPrefs();

  static const _pageTransitionsTheme = PageTransitionsTheme(
    builders: {
      TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
    },
  );

  @override
  void initState() {
    super.initState();
    _prefs.themeModeNotifier.addListener(_onSettingsChanged);
    _prefs.dynamicColorNotifier.addListener(_onSettingsChanged);
    _prefs.accentColorNotifier.addListener(_onSettingsChanged);

    SystemChrome.setSystemUIChangeCallback(_onFullscreenChange);
  }

  void _onSettingsChanged() {
    setState(() {});
  }

  Future<void> _onFullscreenChange(bool systemOverlaysAreVisible) async {
    await ThemedApp.setFullscreen(!systemOverlaysAreVisible,
        updateSystem: false);
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = _prefs.themeModeNotifier.value;
    final useDynamicColor = _prefs.dynamicColorNotifier.value;
    final accentColor = _prefs.accentColorNotifier.value;

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        final Color seedColor = accentColor;

        ColorScheme lightScheme;
        ColorScheme darkScheme;

        if (useDynamicColor &&
            deviceInfo.supportsDynamicColor &&
            lightDynamic != null &&
            darkDynamic != null) {
          lightScheme = lightDynamic;
          darkScheme = darkDynamic;
        } else {
          lightScheme = ColorScheme.fromSeed(
              seedColor: seedColor, brightness: Brightness.light);
          darkScheme = ColorScheme.fromSeed(
              seedColor: seedColor, brightness: Brightness.dark);
        }

        final bool isDarkMode;
        if (themeMode == ThemeMode.system) {
          isDarkMode =
              MediaQuery.of(context).platformBrightness == Brightness.dark;
        } else {
          isDarkMode = themeMode == ThemeMode.dark;
        }

        lightScheme = _fixSurfaceContainers(lightScheme);
        darkScheme = _fixSurfaceContainers(darkScheme);

        return MaterialApp.router(
          title: widget.title,
          color: isDarkMode ? darkScheme.surface : lightScheme.surface,
          routerConfig: widget.router,
          locale: TranslationProvider.of(context).flutterLocale,
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: [...GlobalMaterialLocalizations.delegates],
          themeMode: themeMode,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightScheme,
            platform: TargetPlatform.android,
            pageTransitionsTheme: _pageTransitionsTheme,
            snackBarTheme: SnackBarThemeData(
              backgroundColor: lightScheme.inverseSurface,
              actionTextColor: lightScheme.inversePrimary,
              behavior: SnackBarBehavior.floating,
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9)),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkScheme,
            platform: TargetPlatform.android,
            pageTransitionsTheme: _pageTransitionsTheme,
            splashFactory: InkSparkle.splashFactory,
            snackBarTheme: SnackBarThemeData(
              backgroundColor: darkScheme.inverseSurface,
              actionTextColor: darkScheme.inversePrimary,
              behavior: SnackBarBehavior.floating,
              elevation: 1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9)),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _prefs.themeModeNotifier.removeListener(_onSettingsChanged);
    _prefs.dynamicColorNotifier.removeListener(_onSettingsChanged);
    _prefs.accentColorNotifier.removeListener(_onSettingsChanged);

    SystemChrome.setSystemUIChangeCallback(null);

    super.dispose();
  }

  ColorScheme _fixSurfaceContainers(ColorScheme scheme) {
    final surface = scheme.surface;
    final tint = scheme.surfaceTint;

    var surfaceContainerLowest = scheme.surfaceContainerLowest;
    var surfaceContainerLow = scheme.surfaceContainerLow;
    var surfaceContainer = scheme.surfaceContainer;
    var surfaceContainerHigh = scheme.surfaceContainerHigh;
    var surfaceContainerHighest = scheme.surfaceContainerHighest;

    if (surfaceContainerLowest == surface) {
      surfaceContainerLowest = switch (scheme.brightness) {
        Brightness.light => Colors.white,
        Brightness.dark => Color.alphaBlend(
            Colors.black45,
            scheme.surfaceDim,
          ),
      };
    }
    if (surfaceContainerLow == surface) {
      surfaceContainerLow = ElevationOverlay.applySurfaceTint(surface, tint, 1);
    }
    if (surfaceContainer == surface) {
      surfaceContainer = ElevationOverlay.applySurfaceTint(surface, tint, 2);
    }
    if (surfaceContainerHigh == surface) {
      surfaceContainerHigh = ElevationOverlay.applySurfaceTint(
        surface,
        tint,
        3,
      );
    }
    if (surfaceContainerHighest == surface) {
      // ignore: deprecated_member_use
      surfaceContainerHighest = scheme.surfaceVariant;
    }

    return scheme.copyWith(
      surfaceContainerLowest: surfaceContainerLowest,
      surfaceContainerLow: surfaceContainerLow,
      surfaceContainer: surfaceContainer,
      surfaceContainerHigh: surfaceContainerHigh,
      surfaceContainerHighest: surfaceContainerHighest,
    );
  }
}
