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
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: _calculateWidthFactor(context),
          child: ListView(
            padding: const EdgeInsets.all(20.0),
            children: [
              attributionWidget(),
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
      padding: const EdgeInsets.only(bottom: 20.0),
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
}
