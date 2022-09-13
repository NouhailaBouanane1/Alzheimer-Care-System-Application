
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Answer extends StatelessWidget {
  final VoidCallback selectHandler;
  final String answerText;

  Answer(this.selectHandler, this.answerText);

  @override
  Widget build(BuildContext context) {
    return  Container(
          width: double.infinity,
          child: InkWell(
            onTap: selectHandler,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5,horizontal: 24),
                padding: EdgeInsets.only(top: 6,bottom: 10,left: 8,right: 8),
                width:double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple),
                    borderRadius: BorderRadius.circular(10),
                  color:Colors.purple[50],
                ),
                child: Text(answerText,style: TextStyle(
                    color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 3
                ),

                ),
              ),
            ),
       //RaisedButton


    ); //Container
  }
}
