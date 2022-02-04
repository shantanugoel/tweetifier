import 'package:flutter/material.dart';

ValueNotifier<String> inputChangeNotifier = ValueNotifier("");

class Input extends StatefulWidget {
  const Input({Key? key}) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  int letterCount = 0;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.multiline,
      minLines: 3,
      maxLines: 20,
      decoration: InputDecoration(
        label: Text("Input: $letterCount"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
      ),
      onChanged: (String value) {
        inputChangeNotifier.value = value;
        setState(() {
          letterCount = value.length;
        });
      },
    );
  }
}
