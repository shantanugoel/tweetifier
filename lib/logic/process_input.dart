// import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter/material.dart';

ValueNotifier<String> inputChangeNotifier = ValueNotifier("");

void processInput(String input) {
  // var parser = EmojiParser();
  inputChangeNotifier.value = input;
}
