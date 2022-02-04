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
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: inputChangeNotifier,
        builder: (context, value, child) {
          // return SelectableText.rich(
          //     TextSpan(text: processInput(value.toString())));
          return processInput2(value.toString(), context);
        });
  }

  Row processInput2(String input, BuildContext context) {
    List<Widget> list = [];
    var tokens = input.split(" ");
    for (var token in tokens) {
      final emoji = Emoji.byKeyword(token);
      if (emoji.isNotEmpty) {
        List<String> alts = [];
        emoji.toList().forEach((e) => alts.add(e.char));
        // _displayedEmojis.add(alts[0]);
        String displayed = emoji.first.char;
        list.add(StatefulBuilder(builder: (context, setState) {
          return GestureDetector(
            onTap: () => showMaterialScrollPicker(
              title: 'Alt',
              context: context,
              items: alts,
              selectedItem: alts[0],
              onChanged: (value) => setState(() {
                displayed = value.toString();
              }),
            ),
            child: Text(displayed),
          );
        })); //RichText(text: TextSpan(text: displayed))));
        // list.add(Text(displayed));
      } else {
        list.add(RichText(text: TextSpan(text: token)));
      }
      // list.add(RichText(text: const TextSpan(text: " ")));
    }
    return Row(
      children: list,
    );
  }
}
