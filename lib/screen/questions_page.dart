import 'dart:math';

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

class BuildQuestion extends StatefulWidget {
  const BuildQuestion({Key? key, required this.question}) : super(key: key);

  final Question question;

  @override
  _BuildQuestionState createState() => _BuildQuestionState();
}

class _BuildQuestionState extends State<BuildQuestion> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(widget.question.question,
            style: const TextStyle(
              fontSize: 20,
            )),
        const SizedBox(
          height: 20,
        ),
        OptionWidget(
          question: widget.question,
          onOptionSelected: (option) {
            print(option);
            setState(() {
              widget.question.answer = option;
            });
          },
        ),
      ],
    );
  }
}

class OptionWidget extends StatefulWidget {
  final Question question;
  final ValueChanged<String> onOptionSelected;

  const OptionWidget({
    Key? key,
    required this.question,
    required this.onOptionSelected,
  }) : super(key: key);

  @override
  State<OptionWidget> createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.question.options
          .map((option) => GestureDetector(
                onTap: () {
                  widget.onOptionSelected(option);
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: option == widget.question.answer
                              ? Colors.green
                              : Colors.white),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(child: Text(option)),
                ),
              ))
          .toList(),
    );
  }
}
