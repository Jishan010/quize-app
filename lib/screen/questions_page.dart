import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:quize_app/entity/Questions.dart';

class QuestionsPage extends StatefulWidget {
  QuestionsPage({Key? key, required this.question, required this.id})
      : super(key: key);

  final Question question;
  int id = 0;

  @override
  State<QuestionsPage> createState() =>
      _QuestionsPageState(question: question, id: id);
}

class _QuestionsPageState extends State<QuestionsPage> {
  final Question question;
  int id = 0;

  _QuestionsPageState({required this.question, required this.id});

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questions'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (id == 0) {
              context.beamToNamed('/');
            } else {
              id--;
              Beamer.of(context).beamToNamed('/questions/$id');
            }
          },
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(question.question),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              if (id < 3) {
                Beamer.of(context).beamToNamed('/questions/${id + 1}');
              }
            },
            child: id == 3 ? const Text('Finish') : const Text('Next'),
          ),
        ],
      ),
    );
  }
}
