import 'package:flutter/material.dart';

ValueNotifier<String> inputChangeNotifier = ValueNotifier("");

class Input extends StatelessWidget {
  const Input({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.multiline,
      minLines: 3,
      maxLines: 5,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
      ),
      onChanged: (String value) {
        inputChangeNotifier.value = value;
      },
    );
  }
}
