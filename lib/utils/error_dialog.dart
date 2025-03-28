import 'package:flutter/material.dart';
import 'package:iyox_wormhole/i18n/strings.g.dart';

Future<void> showErrorDialog({required BuildContext context, String? errorMessage}) async {
  await showDialog<void>(
    context: context,
    builder: (ctx) {
      return AlertDialog(
        title: Text(t.common.generic_error),
        content: errorMessage != null ? Text(errorMessage) : null,
        actions: [
          TextButton(
              onPressed: () => Navigator.of(ctx, rootNavigator: true).pop(),
              child: Text(t.common.generic_acknowledge))
        ],
      );
    },
    barrierDismissible: true,
  );
}
