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
          widthFactor: 0.7,
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
}
