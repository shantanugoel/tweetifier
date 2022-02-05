import 'package:flutter/material.dart';
import 'package:tweetifier/widgets/input.dart';
import 'package:tweetifier/widgets/output.dart';

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
            children: const [
              Input(),
              Output(),
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
}
