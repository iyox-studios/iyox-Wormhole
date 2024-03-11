import 'package:flutter/material.dart';

class SettingField extends StatefulWidget {
  const SettingField(
      {super.key,
      required this.title,
      required this.initialValue,
      required this.onSubmit, this.editWidget});

  final String title;
  final String initialValue;
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
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        shape: MaterialStateProperty.all(LinearBorder.none),
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).colorScheme.background),
        textStyle: MaterialStateProperty.all(
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
                      style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    Text(
                      widget.initialValue,
                      style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.onBackground),
                    )
                  ]))),
    );
  }

  void _onPressed() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text(widget.title),
          content:  widget.editWidget ?? TextField(
            controller: _textController,
            onSubmitted: widget.onSubmit,
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
