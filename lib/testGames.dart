
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class testGames extends StatefulWidget{
  String name;
  String image;
  testGames({required this.name,required this.image});
  @override
  State<StatefulWidget> createState() =>testGamesState();
}
class testGamesState extends State<testGames> {
  bool tapped=false;
  double heightCard=130;
  double widthCardPercentage=0.95;
  double cardImage=55;
  double titleFontSize=42;
 @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
   margin: EdgeInsets.only(top: 20),
      height: heightCard+20,
      width: size.width+20,
    //  color: Colors.grey,
      child: Stack(
        children: [
        Center(
              child: AnimatedContainer(
                margin: EdgeInsets.only(left: 24,right: 24),
                duration: Duration(microseconds: 275),
                height: tapped? heightCard-10:heightCard ,
                width: tapped? size.width * widthCardPercentage- 0.3: size.width *widthCardPercentage ,
                decoration: BoxDecoration(
                  color:Colors.white,
                  borderRadius:BorderRadius.circular(10),
                  boxShadow:[
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 15,
                      spreadRadius: 5,
                    ),

                  ] ,

                ),
                  child:Container(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text(
                         widget.name,
                         style: TextStyle(
                           fontSize: tapped? titleFontSize-1:titleFontSize,
                           fontWeight: FontWeight.bold,
                           color: Colors.black87,


                         ),

                       )
                     ],
                   ),
                  )
      ),

    ),
          Align(
            alignment: Alignment.centerLeft,
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.asset(
                widget.image,
                fit: BoxFit.fill,
                width:tapped? cardImage-8:cardImage,
                height: tapped? cardImage-5:cardImage,
              ),
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(16) ),
              margin: EdgeInsets.all(6),
              elevation: 5,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Icon(
                          Icons.arrow_forward_ios_rounded,color: Colors.pink,size: 30,
              ),
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15) ),
              margin: EdgeInsets.all(16),
              elevation: 5,
            ),
          )
        ],
      ),
    );
  }
}

