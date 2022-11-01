import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to Quiz App'),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Beamer.of(context).beamToNamed('/questions');
              },
              child: const Text('Start Quiz'),
            )
          ],
        ),
      ),
    );
  }
}
