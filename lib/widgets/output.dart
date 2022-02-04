import 'package:flutter/material.dart';
import 'package:tweetifier/widgets/emoji.dart';
import 'package:tweetifier/widgets/input.dart';
import 'package:emojis/emoji.dart';

class Output extends StatefulWidget {
  const Output({Key? key}) : super(key: key);

  @override
  State<Output> createState() => _OutputState();
}

class _OutputState extends State<Output> {
  int letterCount = 0;
  List<String> outputString = [];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ValueListenableBuilder(
          valueListenable: inputChangeNotifier,
          builder: (context, value, child) {
            return processInput2(value.toString(), context);
          })
    ]);
  }

// TODO:
// Copyable text
// Removing opportunistic spacing/punctuation
// Branding and tracking

  Widget processInput2(String input, BuildContext context) {
    List<Widget> list = [];
    var tokens = input.split(" ");
    var tokensProcessed = 0;
    int i = -1;
    outputString.clear();
    letterCount = 0;
    for (var token in tokens) {
      var skipChars = ["'", ".", ",", ":", "\""];
      var leadingTaken =
          token.characters.takeWhile((p0) => skipChars.contains(p0)).toString();
      var leadingFiltered =
          token.characters.skipWhile((p0) => skipChars.contains(p0));
      var trailingTaken = leadingFiltered
          .takeLastWhile((p0) => skipChars.contains(p0))
          .toString();
      var tokenFiltered = leadingFiltered
          .skipLastWhile((p0) => skipChars.contains(p0))
          .toString();
      final emoji = Emoji.byKeyword(tokenFiltered);
      if (leadingTaken.isNotEmpty) {
        list.add(Text(leadingTaken));
        letterCount += leadingTaken.length;
        ++i;
        outputString.add(leadingTaken);
      }
      if (emoji.isNotEmpty) {
        List<String> alts = [tokenFiltered];
        emoji.toList().forEach((e) => alts.add(e.char));
        String displayed = emoji.first.char;
        letterCount++;
        ++i;
        outputString.add(displayed);
        list.add(EmojiDisplay(index: i, alts: alts));
      } else {
        list.add(Text(tokenFiltered));
        letterCount += tokenFiltered.length;
        ++i;
        outputString.add(tokenFiltered);
      }
      if (trailingTaken.isNotEmpty) {
        list.add(Text(trailingTaken));
        letterCount += trailingTaken.length;
        ++i;
        outputString.add(trailingTaken);
      }
      tokensProcessed++;
      if (tokensProcessed != tokens.length) {
        list.add(const Text(" "));
        letterCount++;
        ++i;
        outputString.add(" ");
      }
    }
    var output = Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.only(top: 10.0),
        child: InputDecorator(
            decoration: InputDecoration(
                label: ValueListenableBuilder(
                  valueListenable: e,
                  builder: (context, value, child) {
                    outputString[e.value.position] = e.value.string;
                    if (e.value.string.isNotEmpty) {
                      letterCount += e.value.string.length - 1;
                    }
                    return Text('Output: $letterCount');
                  },
                ),
                contentPadding: const EdgeInsets.only(top: 10.0)),
            child: Wrap(
              children: list,
            )));

    return output;
  }
}
