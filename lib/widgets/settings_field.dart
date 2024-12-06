import 'package:flutter/material.dart';

class SettingField extends StatefulWidget {
  const SettingField(
      {super.key,
      required this.title,
      required this.initialValue,
      required this.onSubmit,
      this.defaultValue = '',
      this.editWidget});

  final String title;
  final String initialValue;
  final String defaultValue;
  final void Function(String) onSubmit;
  final Widget? editWidget;

  @override
  State<SettingField> createState() => _SettingFieldState();
}

class _SettingFieldState extends State<SettingField> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();

    _textController = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.zero),
        shape: WidgetStateProperty.all(LinearBorder.none),
        backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.surface),
        textStyle: WidgetStateProperty.all(
          TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      onPressed: _onPressed,
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
                    ),
                    Text(
                      widget.initialValue,
                      style: TextStyle(fontSize: 15, color: Theme.of(context).colorScheme.onSurface),
                    )
                  ]))),
    );
  }

  void _onPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text(widget.title),
          content: widget.editWidget ??
              TextField(
                controller: _textController,
                onSubmitted: widget.onSubmit,
                decoration: InputDecoration(
                  hintText: widget.defaultValue,
                  suffixIcon: IconButton(
                    onPressed: _textController.clear,
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Save'),
              onPressed: () {
                widget.onSubmit(_textController.text);
                Navigator.of(context).pop();
              },
            ),
          ]),
    );
  }
}
