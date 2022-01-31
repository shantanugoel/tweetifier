import 'package:emojis/emoji.dart';
import 'package:flutter/material.dart';

ValueNotifier<String> inputChangeNotifier = ValueNotifier("");

void processInput(String input) {
  String output = "";
  var tokens = input.split(" ");
  for (var token in tokens) {
    // Can also use synonyms? e.g. heart instead of love
    final emoji = Emoji.byKeyword(token);
    // output += (emoji == Emoji.None) ? token : emoji.code;
    if (emoji != null) {
      // Fix this condition. Also this is too strong. Maybe avoid doing for 1/2 characters
      output += emoji.first.char;
    } else {
      output += token;
    }
    output += " ";
  }
  inputChangeNotifier.value = output;
}

//use share_plus package for sharing
// can also try emojis  or dart_emoji package