import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter/material.dart';

ValueNotifier<String> inputChangeNotifier = ValueNotifier("");

void processInput(String input) {
  var parser = EmojiParser();
  String output = "";
  var tokens = input.split(" ");
  for (var token in tokens) {
    // Can also use synonyms? e.g. heart instead of love
    var emoji = parser.get(token);
    output += (emoji == Emoji.None) ? token : emoji.code;
    output += " ";
  }
  inputChangeNotifier.value = output;
}
