import 'package:flutter/material.dart';

Color themeAwareTint(Color color, Brightness brightness, [double amount = 0.1]) {
  assert(amount >= 0 && amount <= 1);
  final hsl = HSLColor.fromColor(color);

  final lightness = brightness == Brightness.dark
      ? hsl.lightness + amount
      : hsl.lightness - amount;
  final hslTinted = hsl.withLightness((lightness).clamp(0.0, 1.0));

  return hslTinted.toColor();
}