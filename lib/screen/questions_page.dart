import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:quize_app/entity/Questions.dart';

import '../utility/custom_linked_list.dart';

class QuestionsPage extends StatefulWidget {
  QuestionsPage({Key? key, required this.currentNode}) : super(key: key);

  CustomLinkedListNode? currentNode;

  @override
  State<QuestionsPage> createState() =>
      _QuestionsPageState(currentNode: currentNode);
}

class _QuestionsPageState extends State<QuestionsPage> {
  CustomLinkedListNode? currentNode;

  _QuestionsPageState({required this.currentNode});

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
            if (currentNode?.previous != null) {
              //beamer back navigation with transition animation
              Beamer.of(context).beamBack(data: currentNode?.previous);
            } else {
              Beamer.of(context).beamBack();
            }
          },
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
              '${currentNode?.value.id}: ${currentNode?.value.question}' ?? ''),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              if (currentNode?.next != null) {
                final questionId = currentNode?.next?.value.id;
                Beamer.of(context).beamToNamed(
                  '/questions/$questionId',
                  data: currentNode?.next,
                );
              } else {
                //TODO: show the result
                /*Beamer.of(context).beamToNamed('/finish');*/
              }
            },
            child: currentNode?.next != null
                ? const Text('Next')
                : const Text('Finish'),
          ),
        ],
      ),
    );
  }
}
