
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Result extends StatelessWidget {
  final double resultScore;
  final VoidCallback resetHandler;

  Result(this.resultScore, this.resetHandler);

//Remark Logic
  String resultPhrase(BuildContext context) {
    String resultText;
    if (resultScore == 0.0) {
      resultText = AppLocalizations.of(context)!.res1;
      print(resultScore);
    } else if ((resultScore >= 0.5) && (resultScore <= 4.5)) {
      resultText = AppLocalizations.of(context)!.res1;
      print(resultScore);
    } else if ((resultScore >= 4.5) && (resultScore <= 9)) {
      resultText = AppLocalizations.of(context)!.res2;
    } else if ((resultScore >= 9.5) && (resultScore <= 15.5)) {
      resultText = AppLocalizations.of(context)!.res3;
    } else {
      resultText =AppLocalizations.of(context)!.res4;
      print(AppLocalizations.of(context)!.res5);
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
         Image.asset("images/f.gif",height: 180,),
        Stack(
          children:[
            Container(
              margin: EdgeInsets.only(right: 10,left: 10),
              height: 180,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.purpleAccent,
                    Colors.deepPurpleAccent,
                  ],),        borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 10,left: 10),
                child: Text(
                  resultPhrase(context),
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),),
          ]
        ),
                    SizedBox(height: 20),//Text
                    Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: FlatButton(
                        child: Container(
                          padding: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(10),

                          ),
                          child: Text(
                            AppLocalizations.of(context)!.restartQuiz,
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ), //Text
                        textColor: Colors.purpleAccent,
                        onPressed:
                          resetHandler,

                      ),
                    ), //FlatButton
                  ], //<Widget>[]

    ); //Center
  }
}
