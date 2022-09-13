import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Board.dart';
import 'package:graduation_project/HomeGame1.dart';
import 'package:graduation_project/game3/MainPageGame3.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../screen6Patient.dart';




class GamesMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text(AppLocalizations.of(context)!.games,
          style: TextStyle(fontSize: 29),),
        backgroundColor: Colors.purpleAccent,
       
      ),
      body: Container(
color: Colors.purpleAccent,
      child: ListView(
          children:[
              Container(
                    margin: EdgeInsets.all(28),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(top: 23),
                            child: Text(
                              AppLocalizations.of(context)!.chooseAGame,

                              style: TextStyle(


                                      color: Colors.white,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w900,
                                      decoration: TextDecoration.none


                              ),
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Stack(
                              overflow: Overflow.visible,
                              children: [
                                Transform(
                                  transform: Matrix4.skewY(-0.06),
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    height: 180,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xFF4A148C),
                                          Color(0xFFF8BBD0),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(25)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10.0),
                                        child: Text(
                                        AppLocalizations.of(context)!.flippingCards ,                                       style: TextStyle(

                                              color: Colors.white,
                                              fontSize: 36,
                                              fontWeight: FontWeight.w900,
                                              decoration: TextDecoration.none


                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, right: 15, left: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            Transform(
                                              transform: Matrix4.skewX(-0.05),
                                              origin: Offset(50.0, 50.0),
                                              child: Material(
                                                borderRadius:
                                                BorderRadius.all(Radius.circular(10)),
                                                child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 30,
                                                        right: 30,
                                                        top: 10,
                                                        bottom: 10),
                                                  child: Row(
                                                    children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                       HomeGame1() ));
                                                          },
                                                          child: Text(
                                                            AppLocalizations.of(context)!.play,

                                                              style: TextStyle(
                                                                color:  Color(0xFF4A148C),
                                                                  fontSize: 34,
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                        ),


                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              Positioned(
                                    bottom: 88,
                                    left: 250,
                                    child: Image(
                                      image: AssetImage('images/games/flipping cards (2).png',

                                      ),
                                      height: 140,
                                      width: 100,

                                  ),
                                  )],
                            ),
                          ),



                          Padding(
                            padding: const EdgeInsets.only(top: 35),
                            child: Text(
                              AppLocalizations.of(context)!.discoverMoreGames,
                              style: TextStyle(


                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.w900,
                                  decoration: TextDecoration.none


                              ),
                            ),
                          ),





                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Stack(
                              overflow: Overflow.visible,
                              children: [
                                Transform(
                                  transform: Matrix4.skewY(-0.06),
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    height: 160,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xFF4A148C),
                                          Color(0xFFF8BBD0),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(25)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10.0),
                                        child: Text(
                                            AppLocalizations.of(context)!.slidingPuzzle  ,                                        style: TextStyle(


                                              color: Colors.white,
                                              fontSize: 36,
                                              fontWeight: FontWeight.w900,
                                              decoration: TextDecoration.none


                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, right: 15, left: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            Transform(
                                              transform: Matrix4.skewX(-0.05),
                                              origin: Offset(50.0, 50.0),
                                              child: Material(
                                                borderRadius:
                                                BorderRadius.all(Radius.circular(10)),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 30,
                                                      right: 30,
                                                      top: 10 ,
                                                      bottom: 2),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      Board()));
                                                        },
                                                        child: Text(
                                                          AppLocalizations.of(context)!.play,
                                                          style: TextStyle(
                                                              color:  Color(0xFF4A148C),
                                                              fontSize: 34,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                      ),


                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 100,
                                  left: 250,
                                  child: Image(
                                    image: AssetImage('images/games/sliding.jpg'),
                                    height: 120,
                                    width: 100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 38),
                            child: Stack(
                              overflow: Overflow.visible,
                              children: [
                                Transform(
                                  transform: Matrix4.skewY(-0.05),
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    height: 160,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xFF4A148C),
                                          Color(0xFFF8BBD0),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(25)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right:10.0),
                                        child: Text(
                                        AppLocalizations.of(context)!.ticTacToe,
                                          style: TextStyle(


                                              color: Colors.white,
                                              fontSize: 36,
                                              fontWeight: FontWeight.w900,
                                              decoration: TextDecoration.none


                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, right: 15, left: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [

                                            Transform(
                                              transform: Matrix4.skewX(-0.05),
                                              origin: Offset(50.0, 50.0),
                                              child: Material(
                                                borderRadius:
                                                BorderRadius.all(Radius.circular(10)),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 30,
                                                      right: 30,
                                                      top: 10,
                                                      bottom: 10),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      MainPageGame3(title: "Tic Tac Toe")));
                                                        },
                                                        child: Text(
                                                    AppLocalizations.of(context)!.play,
                                                          style: TextStyle(
                                                              color: Color(0xFF4A148C),
                                                              fontSize: 34,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                      ),


                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  bottom: 100,
                                  left: 250,
                                  child: Image(
                                    image: AssetImage('images/games/tictoc.jpg'),
                                    height: 120,
                                    width: 100,
                                  ),
                                ),
                              ],
                            ),
                          ),





                        ])

                )

          ]
        ),
      ),
    );
  }
}