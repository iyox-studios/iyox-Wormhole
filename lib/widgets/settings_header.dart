import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Gap(35),
      Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Text(title,
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 18,
                fontWeight: FontWeight.w500)),
      ),
      const Gap(5)
    ]);
  }
}
