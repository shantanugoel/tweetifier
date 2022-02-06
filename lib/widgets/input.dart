import 'package:flutter/material.dart';

ValueNotifier<String> inputChangeNotifier = ValueNotifier("");

class Input extends StatefulWidget {
  const Input({Key? key}) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  int letterCount = 0;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.multiline,
      controller: _controller,
      minLines: 3,
      maxLines: 20,
      autofocus: true,
      decoration: InputDecoration(
        label: Text("Input: $letterCount"),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
          ),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => _controller.clear(),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_inputChanged);
  }

  void _inputChanged() {
    setState(() {
      letterCount = _controller.text.characters.length;
    });
    inputChangeNotifier.value = _controller.text;
  }
}
