import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/QUIIZ/quiz.dart';
import 'package:graduation_project/QUIIZ/result.dart';
import 'package:graduation_project/screen2Patient.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'answer.dart';

class QuizAppmain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => QuizAppmainState();
}

class QuizAppmainState extends State<QuizAppmain> {
  final _questions = const [
    //list
    //list of maps
    {
      "questionText":
          "What level of memory loss is the individual experiencing?",
      "answers": [
        {"text": "No loss of memory or sporadic forgetfulness.", "score": 0.0},
        {
          "text":
              "Consistent forgetfulness and partial recollection of events (which they may have fully recollected in the past).",
          "score": 0.5
        },
        {
          "text":
              "Moderate memory loss that impacts recent events more severely than distant memories. Memory loss impacts daily activities.",
          "score": 1.0
        },
        {
          "text":
              "Severe memory loss, recollection of recent events limited, long term memories may be retained but incomplete.",
          "score": 2.0
        },
        {
          "text":
              "Severe memory loss, almost no recollection of recent events and highly fragmented long-term memory.",
          "score": 3.0
        },
      ]
    },
    {
      "questionText":
          "What level of time and geographic disorientation is the individual experiencing?",
      "answers": [
        {"text": "No disorientation.", "score": 0.0},
        {
          "text":
              "Minor difficulty with time relationships (such as the order of events or distortion of fixed time periods such as minutes, hours or an afternoon).",
          "score": 0.5
        },
        {
          "text":
              "Moderate difficulty with time relationships and occasional geographic disorientation (such as getting lost within an area well-known to the person).",
          "score": 1.0
        },
        {
          "text":
              "Severe difficulty with time relationships; disoriented to time and place on a daily basis.",
          "score": 2.0
        },
        {
          "text": "Oriented to present moment only or to their present moment.",
          "score": 3.0
        },
      ]
    },
    {
      "questionText":
          "Is the individual having challenges with judgement and product solving?",
      "answers": [
        {
          "text":
              "Shows no diminished ability in handling problems, business and financial affairs.",
          "score": 0.0
        },
        {
          "text":
              "Shows minor impairment in judgment and with solving problems relative to past performance on similar tasks.",
          "score": 0.5
        },
        {
          "text":
              "Has moderate difficulty in handling problems, may show occasional social judgment issues.",
          "score": 1.0
        },
        {
          "text":
              "Has severe difficulty in handling problems and presents persistent social judgment issues.",
          "score": 2.0
        },
        {
          "text": "Completely unable to make judgments or solve problems.",
          "score": 3.0
        },
      ]
    },

    {
      "questionText":
          "How does the individual function in their community, outside of their home?",
      "answers": [
        {
          "text":
              "They function independently continuing to shop, volunteer and socialize as they have in the past.",
          "score": 0.0
        },
        {
          "text":
              "They show slight impairment in shopping and socializing but can do so with minor assistance.",
          "score": 0.5
        },
        {
          "text":
              "Unable to function independently outside the home but can appear normal to a casual observer.",
          "score": 1.0
        },
        {
          "text":
              "Unable to function independently outside the home but functions well enough to be taken to some functions.",
          "score": 2.0
        },
        {
          "text":
              "Cannot be taken outside the home without constant monitoring.",
          "score": 3.0
        },
      ]
    },
    {
      "questionText":
          "How does the individual function within their home with chores and hobbies? (Do not consider personal hygiene in this question).",
      "answers": [
        {
          "text":
              "They continue to complete in-home chores, pursue hobbies and maintain interests as they have always done.",
          "score": 0.0
        },
        {
          "text":
              "They continue to perform chores and pursue interests but with some challenges due to cognitive issues.",
          "score": 0.5
        },
        {
          "text":
              "They have given up performing more complex chores and interests but still pursue simpler ones.",
          "score": 1.0
        },
        {
          "text":
              "They can perform only simple chores and may not do so correctly.",
          "score": 2.0
        },
        {
          "text": "They have no significant function within the home.",
          "score": 3.0
        },
      ]
    },
    {
      "questionText":
          "What level of personal hygiene and personal care does the individual maintain?",
      "answers": [
        {
          "text":
              "They are fully capable of self-care and do so without prompting.",
          "score": 0.0
        },
        {"text": "They are fully capable of self-care", "score": 0.5},
        {
          "text":
              "They are capable of self-care but may require the occasional prompt and assistance with clothing decisions.",
          "score": 1.0
        },
        {
          "text":
              "They require significant assistance with self-care, frequent prompting and have difficulty keeping track of their personal effects.",
          "score": 2.0
        },
        {
          "text":
              "They require daily assistance with hygiene, personal care and are frequently incontinent.",
          "score": 3.0
        },
      ]
    },
  ];

  var _questionIndex = 0;
  double _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(double score, List questions) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    if (_questionIndex < questions.length) {
      print(
        AppLocalizations.of(context)!.moreQuestion,
      );
    } else {
      print(
        AppLocalizations.of(context)!.noMoreQuestion,
      );
    }
  }

  List questions(BuildContext context) {
    return [
      //list
      //list of maps
      {
        "questionText": AppLocalizations.of(context)!.q1,
        "answers": [
          {"text": AppLocalizations.of(context)!.q1Ans1, "score": 0.0},
          {"text": AppLocalizations.of(context)!.q1Ans2, "score": 0.5},
          {"text": AppLocalizations.of(context)!.q1Ans3, "score": 1.0},
          {"text": AppLocalizations.of(context)!.q1Ans4, "score": 2.0},
          {"text": AppLocalizations.of(context)!.q1Ans5, "score": 3.0},
        ]
      },
      {
        "questionText": AppLocalizations.of(context)!.q2,
        "answers": [
          {"text": AppLocalizations.of(context)!.q2Ans1, "score": 0.0},
          {"text": AppLocalizations.of(context)!.q2Ans2, "score": 0.5},
          {"text": AppLocalizations.of(context)!.q2Ans3, "score": 1.0},
          {"text": AppLocalizations.of(context)!.q2Ans4, "score": 2.0},
          {"text": AppLocalizations.of(context)!.q2Ans5, "score": 3.0},
        ]
      },
      {
        "questionText": AppLocalizations.of(context)!.q3,
        "answers": [
          {"text": AppLocalizations.of(context)!.q3Ans1, "score": 0.0},
          {"text": AppLocalizations.of(context)!.q3Ans2, "score": 0.5},
          {"text": AppLocalizations.of(context)!.q3Ans3, "score": 1.0},
          {"text": AppLocalizations.of(context)!.q3Ans4, "score": 2.0},
          {"text": AppLocalizations.of(context)!.q3Ans5, "score": 3.0},
        ]
      },

      {
        "questionText": AppLocalizations.of(context)!.q4,
        "answers": [
          {"text": AppLocalizations.of(context)!.q4Ans1, "score": 0.0},
          {"text": AppLocalizations.of(context)!.q4Ans2, "score": 0.5},
          {"text": AppLocalizations.of(context)!.q4Ans3, "score": 1.0},
          {"text": AppLocalizations.of(context)!.q4Ans4, "score": 2.0},
          {"text": AppLocalizations.of(context)!.q4Ans5, "score": 3.0},
        ]
      },
      {
        "questionText": AppLocalizations.of(context)!.q5,
        "answers": [
          {"text": AppLocalizations.of(context)!.q1Ans5, "score": 0.0},
          {"text": AppLocalizations.of(context)!.q5Ans2, "score": 0.5},
          {"text": AppLocalizations.of(context)!.q5Ans3, "score": 1.0},
          {"text": AppLocalizations.of(context)!.q5Ans4, "score": 2.0},
          {"text": AppLocalizations.of(context)!.q5Ans5, "score": 3.0},
        ]
      },
      {
        "questionText": AppLocalizations.of(context)!.q6,
        "answers": [
          {"text": AppLocalizations.of(context)!.q6Ans1, "score": 0.0},
          {"text": AppLocalizations.of(context)!.q6Ans2, "score": 0.5},
          {"text": AppLocalizations.of(context)!.q6Ans3, "score": 1.0},
          {"text": AppLocalizations.of(context)!.q6Ans4, "score": 2.0},
          {"text": AppLocalizations.of(context)!.q6Ans5, "score": 3.0},
        ]
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    List _questions = questions(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.test,
          style: TextStyle(fontSize: 29),
        ),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Center(
          child: ListView(
        children: [
          Container(
            child: _questionIndex < _questions.length
                ? Quiz(
                    answerQuestion: _answerQuestion,
                    questionIndex: _questionIndex,
                    questions: _questions,
                  ) //Quiz
                : Result(_totalScore, _resetQuiz),
          ),
        ],
      ) //Padding

          ),
    ); //MaterialApp
  }
}
