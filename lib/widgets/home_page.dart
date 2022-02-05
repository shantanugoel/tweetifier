import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tweetifier/widgets/input.dart';
import 'package:tweetifier/widgets/output.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tweetifier'),
        actions: [
          IconButton(
            onPressed: () => showHelp(context),
            icon: const Icon(
              Icons.help,
            ),
            iconSize: 32,
          )
        ],
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: _calculateWidthFactor(context),
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              attributionWidget(),
              tip(),
              const Input(),
              const Output(),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateWidthFactor(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return 0.9;
    }
    return 0.7;
  }

  Widget attributionWidget() {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'Built with ❤️ by ',
          children: [
            TextSpan(
                text: '@shantanugoel',
                style: const TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => launch('https://twitter.com/shantanugoel'))
          ],
        ),
      ),
    );
  }

  Widget tip() {
    return Container(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: const Text(
          'ProTip: Click on any emoji in the output to choose an alternate'
          ' version, or go back to its text form',
          textAlign: TextAlign.center,
        ));
  }

  void showHelp(BuildContext context) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Help'),
        content: const Text('''
 • Type in (or paste) any text in the input box
 • Emojified output will appear in the output box as you type
 • After writing all content, you can also click on any emoji and choose an alternate version of that emoji, or go back to text form
 • Click on "Copy to Clipboard" to copy it and paste it on twitter or anywhere else '''),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context), child: const Text('Ok')),
        ],
      ),
    );
  }
}
