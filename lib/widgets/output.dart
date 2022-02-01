import 'package:flutter/material.dart';
import 'package:tweetifier/process_input.dart';
import 'package:tweetifier/widgets/input.dart';

class Output extends StatelessWidget {
  const Output({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: inputChangeNotifier,
        builder: (context, value, child) {
          return SelectableText.rich(
              TextSpan(text: processInput(value.toString())));
        });
  }
}
