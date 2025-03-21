import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:iyox_wormhole/i18n/strings.g.dart';
import 'package:iyox_wormhole/utils/device_info.dart';
import 'package:iyox_wormhole/utils/logger.dart';

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

  static void setFullscreen(bool value, {required bool updateSystem}) {
    _isFullscreen.value = value;
    if (!updateSystem) return;
    getLogger().f('TODO Fullscreen');

    /*SystemChrome.setEnabledSystemUIMode(
        value ? SystemUiMode.immersive : SystemUiMode.edgeToEdge);*/
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

  static const _pageTransitionsTheme = PageTransitionsTheme(
    builders: {
      TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
    },
  );

  @override
  void initState() {
    super.initState();
    //Prefs.appTheme.addListener(onChanged);
    //Prefs.platform.addListener(onChanged);
    //Prefs.accentColor.addListener(onChanged);
    //Prefs.hyperlegibleFont.addListener(onChanged);

    //windowManager.addListener(this);
    SystemChrome.setSystemUIChangeCallback(_onFullscreenChange);

    super.initState();
  }

  void onChanged() {
    setState(() {});
  }

  Future<void> _onFullscreenChange(bool systemOverlaysAreVisible) async {
    ThemedApp.setFullscreen(!systemOverlaysAreVisible, updateSystem: false);
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        final useSystemColors = true; // settings.design.dynamicColors.value;
        final themeMode = ThemeMode.system; // settings
        final customAccent = widget.defaultSwatch; // settings

        // final Color seedColor;
        ColorScheme lightScheme;
        ColorScheme darkScheme;

        if (useSystemColors && deviceInfo.supportsDynamicColor) {
          lightScheme = lightDynamic ??
              ColorScheme.fromSeed(
                  seedColor: customAccent, brightness: Brightness.light);
          darkScheme = darkDynamic ??
              ColorScheme.fromSeed(
                  seedColor: customAccent, brightness: Brightness.dark);
        } else {
          lightScheme = ColorScheme.fromSeed(
              seedColor: customAccent, brightness: Brightness.light);
          darkScheme = ColorScheme.fromSeed(
              seedColor: customAccent, brightness: Brightness.dark);
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
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          themeMode: themeMode,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightScheme,
            //scaffoldBackgroundColor: lightScheme.surface,
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
            //scaffoldBackgroundColor: darkScheme.surface,
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
    //Prefs.appTheme.removeListener(onChanged);
    //Prefs.platform.removeListener(onChanged);
    //Prefs.accentColor.removeListener(onChanged);
    //Prefs.hyperlegibleFont.removeListener(onChanged);

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
