import 'dart:ffi';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:quize_app/entity/Questions.dart';
import 'package:quize_app/screen/questions_page.dart';
import 'package:quize_app/utility/custom_linked_list.dart';

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
          CustomLinkedListNode? currentNode;
          CustomLinkedList customLinkedList = CustomLinkedList();
          // Take the path parameter of interest from BeamState
          if (null == data) {
            List<Question> list = sample_data
                .map((item) => Question(
                      id: item['id'],
                      question: item['question'],
                    ))
                .toList();

            list.forEach((element) {
              customLinkedList.add(element);
            });
            currentNode = customLinkedList.head;
          } else {
            currentNode = data as CustomLinkedListNode?;
          }
          return BeamPage(
            key: ValueKey(currentNode?.value.id),
            child: QuestionsPage(currentNode: currentNode),
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
