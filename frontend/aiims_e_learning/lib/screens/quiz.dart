import 'package:flutter/material.dart';

import 'answer.dart';
import 'question.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;
  final Color answercolor;

  Quiz(
      {@required this.questions,
      @required this.answerQuestion,
      @required this.questionIndex,
      @required this.answercolor});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          height: height / 3,
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Question(
                questions[questionIndex]['questionText'],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ), //Question
        Column(
          children: [
            ...(questions[questionIndex]['answers']
                    as List<Map<String, Object>>)
                .map((answer) {
              return Answer(() => answerQuestion(answer['score']),
                  answer['text'], answer['answercolor']);
            }).toList()
          ],
        ),
      ],
    ); //Column
  }
}
