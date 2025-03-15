import 'package:flutter/material.dart';

class LargeIconButton extends StatelessWidget {
  const LargeIconButton({super.key, required this.onPressed, required this.label, required this.icon});

  final VoidCallback onPressed;
  final Widget label;
  final IconData icon;

  static final ButtonStyle buttonStyle = ButtonStyle(
    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(200),
      ),
    ),
    fixedSize: WidgetStateProperty.all<Size>(Size.fromHeight(64)),
  );

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onPressed,
      style: buttonStyle,
      label: label,
      icon: Icon(icon),
    );
  }
}
