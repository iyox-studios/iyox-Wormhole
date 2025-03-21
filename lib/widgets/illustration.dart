import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iyox_wormhole/widgets/illustration_color_mapper.dart';

class Illustration extends StatelessWidget {
  const Illustration(
      {super.key,
      required this.label,
      required this.assetPath,
      required this.width});

  final String label;
  final String assetPath;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture(
      SvgAssetLoader(
        assetPath,
        colorMapper: IllustrationColorMapper(
            //baseColor: Theme.of(context).colorScheme.brightness == Brightness.dark ? Color(0xff181a1b) : Colors.white,
            baseColor: Theme.of(context).colorScheme.surfaceBright,
            secondaryColor: Theme.of(context).colorScheme.surfaceContainerHigh,
            accentColor: Theme.of(context).colorScheme.tertiary,
            tertiaryColor: Theme.of(context).colorScheme.onSurface),
      ),
      semanticsLabel: label,
      width: width,
    );
  }
}
