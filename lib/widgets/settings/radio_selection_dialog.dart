import 'package:flutter/material.dart';
import 'package:iyox_wormhole/i18n/strings.g.dart';

class RadioOption<T> {
  final T value;
  final String title;

  const RadioOption({required this.value, required this.title});
}

class RadioSelectionDialog<T> extends StatelessWidget {
  const RadioSelectionDialog({
    super.key,
    required this.title,
    required this.currentValue,
    required this.options,
    required this.onChanged,
  });

  final String title;
  final T? currentValue;
  final List<RadioOption<T>> options;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: options.map((option) {
            return RadioListTile<T?>(
              title: Text(option.title),
              value: option.value,
              groupValue: currentValue,
              onChanged: (value) {
                onChanged(value);
                Navigator.of(context).pop();
              },
            );
          }).toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(t.common.cancel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
