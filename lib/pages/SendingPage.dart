import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class SendingPage extends StatefulWidget {
  const SendingPage({Key? key, required this.files}) : super(key: key);

  final FilePickerResult files;

  @override
  State<SendingPage> createState() => _SendingPageState();
}

class _SendingPageState extends State<SendingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(widget.files.count.toString()),
        ),
      ),
    );
  }
}
