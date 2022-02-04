import 'package:flutter/material.dart';
import 'package:tweetifier/widgets/input.dart';
import 'package:emojis/emoji.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

class Output extends StatefulWidget {
  const Output({Key? key}) : super(key: key);

  @override
  State<Output> createState() => _OutputState();
}

class _OutputState extends State<Output> {
  int letterCount = 0;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: inputChangeNotifier,
        builder: (context, value, child) {
          return processInput2(value.toString(), context);
        });
  }

// TODO:
// Letter Count
// Copyable text
// Removing opportunistic spacing/punctuation
// Branding and tracking

  Widget processInput2(String input, BuildContext context) {
    List<Widget> list = [];
    var tokens = input.split(" ");
    var tokensProcessed = 0;
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
      list.add(Text(leadingTaken));
      letterCount += leadingTaken.length;
      if (emoji.isNotEmpty) {
        List<String> alts = [tokenFiltered];
        emoji.toList().forEach((e) => alts.add(e.char));
        String displayed = emoji.first.char;
        letterCount++;
        list.add(StatefulBuilder(builder: (context, setState) {
          return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => showMaterialScrollPicker(
                  title: 'Alt',
                  context: context,
                  items: alts,
                  selectedItem: alts[0],
                  onChanged: (value) => setState(() {
                    displayed = value.toString();
                    letterCount = letterCount + value.toString().length - 1;
                  }),
                ),
                child: Text(displayed),
              ));
        }));
      } else {
        list.add(Text(tokenFiltered));
        letterCount += tokenFiltered.length;
      }
      list.add(Text(trailingTaken));
      letterCount += trailingTaken.length;
      tokensProcessed++;
      if (tokensProcessed != tokens.length) {
        list.add(const Text(" "));
        letterCount++;
      }
    }
    var output = Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.only(top: 10.0),
        child: InputDecorator(
            decoration: InputDecoration(
                labelText: "Output: $letterCount",
                contentPadding: const EdgeInsets.only(top: 10.0)),
            child: Wrap(
              children: list,
            )));

    return output;
  }
}
