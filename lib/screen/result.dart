import 'package:flutter/material.dart';
import 'package:beamer/beamer.dart';
import '../entity/Questions.dart';

class Result extends StatelessWidget {
  List<Question> result;

  Result({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result !'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Beamer.of(context).beamBack();
          },
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${result[index].id}. ${result[index].question}'),
            trailing: Text(
                result[index].answer == result[index].userAnswer
                    ? 'Correct'
                    : 'Wrong',
                style: TextStyle(
                    color: result[index].answer == result[index].userAnswer
                        ? Colors.green
                        : Colors.red)),
            subtitle: Text('${result[index].userAnswer}'),
          );
        },
        itemCount: result.length,
      ),
    );
  }
}
