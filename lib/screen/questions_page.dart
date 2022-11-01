import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:quize_app/entity/Questions.dart';

import '../utility/custom_linked_list.dart';

class QuestionsPage extends StatefulWidget {
  QuestionsPage({Key? key, required this.questionList}) : super(key: key);

  List<Question> questionList;

  @override
  State<QuestionsPage> createState() =>
      _QuestionsPageState(questionList: questionList);
}

class _QuestionsPageState extends State<QuestionsPage> {
  List<Question> questionList;

  _QuestionsPageState({required this.questionList});

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
            Beamer.of(context).beamBack();
          },
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
              child: PageView.builder(
            itemBuilder: (context, index) {
              return BuildQuestion(
                question: questionList[index],
              );
            },
            itemCount: questionList.length,
          )),
        ],
      ),
    );
  }
}

Column BuildQuestion({required Question question}) {
  return Column(
    children: [
      Text(question.question),
      ...question.options
          .map((e) => ElevatedButton(
                onPressed: () {},
                child: Text(e),
              ))
          .toList()
    ],
  );
}
