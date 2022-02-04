import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

class EmojiPos {
  final int index;
  final String value;
  const EmojiPos(this.index, this.value);
}

ValueNotifier<EmojiPos> e = ValueNotifier(const EmojiPos(0, ""));

class EmojiDisplay extends StatefulWidget {
  final int index;
  final List<String> alts;

  const EmojiDisplay({Key? key, required this.index, required this.alts})
      : super(key: key);

  @override
  _EmojiDisplayState createState() => _EmojiDisplayState();
}

class _EmojiDisplayState extends State<EmojiDisplay> {
  String displayed = "";

  @override
  Widget build(BuildContext context) {
    displayed = widget.alts[1];
    return StatefulBuilder(builder: (context, setState) {
      return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => showMaterialScrollPicker(
              title: 'Alt',
              context: context,
              items: widget.alts,
              selectedItem: displayed,
              onChanged: (value) => setState(() {
                displayed = value.toString();
                print(displayed);
                // letterCount = letterCount + value.toString().length - 1;
                // l.value = letterCount;
                // os[i] = displayed;
                e.value = EmojiPos(widget.index, displayed);
              }),
            ),
            child: Text(displayed),
          ));
    });
  }
}
