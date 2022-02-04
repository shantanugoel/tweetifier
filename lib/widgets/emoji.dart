import 'package:flutter/material.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';

class EmojiPicked {
  final int position;
  final String string;
  const EmojiPicked(this.position, this.string);
}

ValueNotifier<EmojiPicked> e = ValueNotifier(const EmojiPicked(0, ""));

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
              title: 'Alternate Emojis',
              context: context,
              items: widget.alts,
              selectedItem: displayed,
              onChanged: (value) => setState(() {
                displayed = value.toString();
                e.value = EmojiPicked(widget.index, displayed);
              }),
            ),
            child: Text(
              displayed,
              style: const TextStyle(fontSize: 20),
            ),
          ));
    });
  }
}
