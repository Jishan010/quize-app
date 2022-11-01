import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:quize_app/entity/Questions.dart';
import 'package:quize_app/screen/questions_page.dart';
import 'package:quize_app/screen/result.dart';

import 'screen/welcome_screen.dart';

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
                answer: 'Delhi',
                userAnswer: ''),
            Question(
                id: 2,
                question: 'What is the capital of USA?',
                options: [
                  'New York',
                  'Washington DC',
                  'Chicago',
                  'Los Angeles'
                ],
                answer: 'Washington DC',
                userAnswer: ''),
            Question(
                id: 3,
                question: 'What is the capital of Canada?',
                options: ['Toronto', 'Vancouver', 'Montreal', 'Ottawa'],
                answer: 'Ottawa',
                userAnswer: ''),
            Question(
                id: 4,
                question: 'What is the capital of Australia?',
                options: ['Sydney', 'Melbourne', 'Brisbane', 'Canberra'],
                answer: 'Canberra',
                userAnswer: ''),
            Question(
                id: 5,
                question: 'What is the capital of Brazil?',
                options: [
                  'Rio de Janeiro',
                  'Sao Paulo',
                  'Brasilia',
                  'Salvador'
                ],
                answer: 'Brasilia',
                userAnswer: ''),
          ];

          return BeamPage(
            key: ValueKey('questions'),
            type: BeamPageType.slideRightTransition,
            child: QuestionsPage(questionList: questionList),
          );
        },
        '/questions/result': (context, state, data) {
          List<Question>? questionList = data as List<Question>;
          if (questionList == null) {
            return const BeamPage(
              key: ValueKey('result'),
              child: Scaffold(
                body: Center(
                  child: Text('No data found'),
                ),
              ),
            );
          } else {
            return BeamPage(
                key: ValueKey('result'),
                type: BeamPageType.slideRightTransition,
                child: Result(result: questionList));
          }
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
