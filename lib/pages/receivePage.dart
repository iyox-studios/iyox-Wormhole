import 'package:flutter/material.dart';

class ReceivePage extends StatelessWidget {
  const ReceivePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(18))),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                label: Text('Code'),
              ),
            ),
          ),
          IconButton(onPressed: () => {}, icon: Icon(Icons.qr_code))
        ],
      ),
    );
  }
}
