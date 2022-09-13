import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String questionText;

  Question(this.questionText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:double.infinity,
      height: 280,
      margin: EdgeInsets.only(bottom: 16,left: 16,right: 16,top: 14),
      padding: EdgeInsets.symmetric(horizontal: 6,vertical: 0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.purpleAccent,
            Colors.deepPurpleAccent,
          ],),        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          questionText,
          style: TextStyle(
              fontSize: 34,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: "RobotoCondensed",
 ),
          textAlign: TextAlign.center,
        ),
      ), //Text
    ); //Container
  }
}
