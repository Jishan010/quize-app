import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:quize_app/entity/Questions.dart';
import 'package:quize_app/screen/questions_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routerDelegate = BeamerDelegate(
    initialPath: '/',
    notFoundPage: const BeamPage(
      key: ValueKey('not-found'),
      child: Scaffold(
        body: Center(
          child: Text('404 - Not Found'),
        ),
      ),
    ),
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/': (context, state, data) => const WelcomeScreen(),
        '/questions': (context, state, data) {
          final questionList = [
            Question(
                id: 1,
                question: 'What is the capital of India?',
                options: ['Delhi', 'Mumbai', 'Kolkata', 'Chennai'],
                answer: ''),
            Question(
                id: 2,
                question: 'What is the capital of USA?',
                options: [
                  'New York',
                  'Washington DC',
                  'Chicago',
                  'Los Angeles'
                ],
                answer: ''),
            Question(
                id: 3,
                question: 'What is the capital of Canada?',
                options: ['Toronto', 'Vancouver', 'Montreal', 'Ottawa'],
                answer: ''),
            Question(
                id: 4,
                question: 'What is the capital of Australia?',
                options: ['Sydney', 'Melbourne', 'Brisbane', 'Canberra'],
                answer: ''),
            Question(
                id: 5,
                question: 'What is the capital of Brazil?',
                options: [
                  'Rio de Janeiro',
                  'Sao Paulo',
                  'Brasilia',
                  'Salvador'
                ],
                answer: ''),
          ];

          return BeamPage(
            key: ValueKey('questions'),
            type: BeamPageType.slideRightTransition,
            child: QuestionsPage(questionList: questionList),
          );
        },
      },
    ),
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Welcome'),
        ),
        body: Container(
          height: double.infinity,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Home'),
              ElevatedButton(
                onPressed: () {
                  // Basic beaming
                  Beamer.of(context).beamToNamed('/questions');
                },
                child: Text('Questions'),
              ),
            ],
          ),
        ));
  }
}
