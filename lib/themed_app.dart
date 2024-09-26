import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemedApp extends StatelessWidget {
  const ThemedApp({super.key, required this.builder});

  final Widget Function(
    ColorScheme lightScheme,
    ColorScheme darkScheme,
    bool isDarkMode,
  ) builder;

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        const themeMode = ThemeMode.system;

        ColorScheme lightScheme =
            ColorScheme.fromSeed(seedColor: Colors.indigo, brightness: Brightness.light);
        ColorScheme darkScheme =
            ColorScheme.fromSeed(seedColor: Colors.indigo, brightness: Brightness.dark);

        if (themeMode == ThemeMode.system) {
          lightScheme = lightDynamic ?? lightScheme;
          darkScheme = darkDynamic ?? darkScheme;
        }

        lightScheme = _fixSurfaceContainers(lightScheme);
        darkScheme = _fixSurfaceContainers(darkScheme);

        final mediaQuery = MediaQuery.of(context);
        final bool isDarkMode;
        if (themeMode == ThemeMode.system) {
          isDarkMode = mediaQuery.platformBrightness == Brightness.dark;
        } else {
          isDarkMode = themeMode == ThemeMode.dark;
        }

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.transparent,
            statusBarBrightness: isDarkMode ? Brightness.light : Brightness.dark,
            statusBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
            systemNavigationBarIconBrightness: isDarkMode ? Brightness.light : Brightness.dark,
          ),
          child: builder(lightScheme, darkScheme, isDarkMode),
        );
      },
    );
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
