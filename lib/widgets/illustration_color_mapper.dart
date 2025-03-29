import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IllustrationColorMapper implements ColorMapper {
  const IllustrationColorMapper({
    required this.baseColor,
    this.accentColor,
    this.secondaryColor,
    this.tertiaryColor,
    this.originalBaseColor = const Color(0xffffffff),
    this.originalSecondaryColor = const Color(0xfff2f2f2),
    this.originalAccentColor = const Color(0xff6c63ff),
    this.originalTertiaryColor = const Color(0xff3f3d56),
  });

  final Color originalBaseColor;
  final Color originalSecondaryColor;
  final Color originalTertiaryColor;
  final Color originalAccentColor;

  final Color baseColor;
  final Color? secondaryColor;
  final Color? tertiaryColor;
  final Color? accentColor;

  @override
  Color substitute(
      String? id, String elementName, String attributeName, Color color) {
    if (color == originalBaseColor) return baseColor;

    final accentColor = this.accentColor;
    if (accentColor != null && color == originalAccentColor) return accentColor;

    final secondaryColor = this.secondaryColor;
    if (secondaryColor != null && color == originalSecondaryColor) {
      return secondaryColor;
    }

    final tertiaryColor = this.tertiaryColor;
    if (tertiaryColor != null && color == originalTertiaryColor) {
      return tertiaryColor;
    }

    return color;
  }
}
