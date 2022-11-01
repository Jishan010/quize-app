import 'dart:math';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:quize_app/entity/Questions.dart';

class QuestionsPage extends StatefulWidget {
  QuestionsPage({Key? key, required this.questionList}) : super(key: key);

  List<Question> questionList;

  @override
  State<QuestionsPage> createState() =>
      _QuestionsPageState(questionList: questionList);
}

class _QuestionsPageState extends State<QuestionsPage> {
  List<Question> questionList;
  int _currentQuestion = 0;
  late PageController _pageController;

  _QuestionsPageState({required this.questionList});

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  ElevatedButton buildNextOrSubmitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.blue,
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {
        if (_currentQuestion < questionList.length - 1) {
          _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);
          setState(() {
            _currentQuestion++;
          });
        } else {
          Beamer.of(context)
              .beamToNamed('/questions/result', data: questionList);
        }
      },
      child: Text(
          _currentQuestion < questionList.length - 1 ? 'Next Page' : 'Submit'),
    );
  }

  ElevatedButton buildPreviousButton() {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.red),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
      ),
      onPressed: () {
        if (_currentQuestion > 0) {
          _pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn);
          setState(() {
            _currentQuestion--;
          });
        } else {
          Beamer.of(context).beamBack();
        }
      },
      child: Text('Prev'),
    );
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
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildPreviousButton(),
              buildNextOrSubmitButton(),
            ],
          ),
          SizedBox(
            height: 20,
          )
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
        Text('${widget.question.id}. ${widget.question.question}',
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
              widget.question.userAnswer = option;
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
                          color: option == widget.question.userAnswer
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
