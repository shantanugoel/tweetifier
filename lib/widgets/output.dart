import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stemmer/SnowballStemmer.dart';
import 'package:tweetifier/widgets/emoji.dart';
import 'package:tweetifier/widgets/input.dart';
import 'package:emojis/emoji.dart';
import 'package:twitter_intent/twitter_intent.dart';
import 'package:url_launcher/url_launcher.dart';

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
            return processInput(value.toString(), context);
          }),
      Wrap(
        alignment: WrapAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () => _copyToClipboard(),
              child: const Text("📔 Copy")),
          const Text(' '),
          ElevatedButton(
              onPressed: () => tweetIt(), child: const Text("🐦 Tweet")),
        ],
      ),
    ]);
  }

  Widget processInput(String input, BuildContext context) {
    List<Widget> list = [];
    var tokens = input.split(" ");
    var tokensProcessed = 0;
    int i = -1;
    outputString.clear();
    SnowballStemmer stemmer = SnowballStemmer();

    letterCount = 0;
    for (var token in tokens) {
      final skipChars = ["'", ".", ",", ":", "\"", "!"];
      final leadingTaken =
          token.characters.takeWhile((p0) => skipChars.contains(p0)).toString();
      final leadingFiltered =
          token.characters.skipWhile((p0) => skipChars.contains(p0));
      final trailingTaken = leadingFiltered
          .takeLastWhile((p0) => skipChars.contains(p0))
          .toString();
      final tokenFiltered = leadingFiltered
          .skipLastWhile((p0) => skipChars.contains(p0))
          .toString();
      final tokenFinal = stemmer.stem(tokenFiltered);

      if (leadingTaken.isNotEmpty) {
        list.add(outputText(leadingTaken));
        letterCount += leadingTaken.length;
        ++i;
        outputString.add(leadingTaken);
      }

      // Build a corpus of possible emoji translations
      final emojiByName = Emoji.byName(tokenFinal);
      final emojiByShortName = Emoji.byShortName(tokenFinal);
      final emojiByKeyword = Emoji.byKeyword(tokenFinal);
      List<Emoji> emoji = [];
      if (emojiByName != null) {
        emoji.add(emojiByName);
      }
      if (emojiByShortName != null) {
        emoji.add(emojiByShortName);
      }
      if (emojiByKeyword.isNotEmpty) {
        emoji.addAll(emojiByKeyword);
      }

      // Don't emojify for single letter words
      if (emoji.isNotEmpty && tokenFiltered.length != 1) {
        List<String> alts = [tokenFiltered];
        for (var e in emoji) {
          alts.add(e.char);
        }
        String displayed = emoji.first.char;
        letterCount++;
        ++i;
        outputString.add(displayed);
        list.add(EmojiDisplay(index: i, alts: alts));
      } else {
        list.add(outputText(tokenFiltered));
        letterCount += tokenFiltered.characters.length;
        ++i;
        outputString.add(tokenFiltered);
      }

      if (trailingTaken.isNotEmpty) {
        list.add(outputText(trailingTaken));
        letterCount += trailingTaken.length;
        ++i;
        outputString.add(trailingTaken);
      }
      tokensProcessed++;
      if (tokensProcessed != tokens.length) {
        list.add(outputText(" "));
        letterCount++;
        ++i;
        outputString.add(" ");
      }
    }

    return Container(
        padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
        margin: const EdgeInsets.only(top: 15.0, bottom: 10.0),
        child: InputDecorator(
            decoration: InputDecoration(
              label: ValueListenableBuilder(
                valueListenable: e,
                builder: (context, value, child) {
                  if (e.value.string.isNotEmpty) {
                    outputString[e.value.position] = e.value.string;
                    letterCount += e.value.string.characters.length - 1;
                  }
                  return Text('Output: $letterCount');
                },
              ),
              border: const OutlineInputBorder(),
            ),
            child: Wrap(
              children: list,
            )));
  }

  Future<void> _copyToClipboard() async {
    var output = outputString.join();
    Clipboard.setData(ClipboardData(text: output))
        .then((_) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Copied to clipboard: ${outputString.join()}"),
                behavior: SnackBarBehavior.floating,
                duration: const Duration(milliseconds: 300),
              ),
            ));
  }

  Text outputText(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20),
    );
  }

  void tweetIt() async {
    final tweet = TweetIntent(
      text: outputString.join(),
    );
    await launch('$tweet');
  }
}
