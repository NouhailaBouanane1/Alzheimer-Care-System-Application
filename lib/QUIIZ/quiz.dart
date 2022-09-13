import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import './answer.dart';
import './question.dart';

class Quiz extends StatelessWidget {
  final List questions;
  final int questionIndex;
  final Function answerQuestion;

  Quiz({
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(

    children: [
        Question(
          questions[questionIndex]['questionText'] as String,
        ), //Question
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(() => answerQuestion(answer['score'],questions), answer['text'] as String);
        }).toList()
      ],
    ); //Column
  }
}
