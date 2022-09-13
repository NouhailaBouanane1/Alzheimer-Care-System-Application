import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/chatbot/chatbot.dart';
import 'package:graduation_project/screen15Patient.dart';
import 'package:graduation_project/testGames.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class screen18Patient extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => screen18PatientState();
}

class screen18PatientState extends State<screen18Patient> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.learnAboutAlz,
            style: TextStyle(fontSize: 29, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.purpleAccent,
        ),
        backgroundColor: Colors.white,
        body: Container(
          child: Stack(
            children: [
              Container(
                width: size.width,
                height: size.height,
                color: Colors.white,
              ),
              Container(
                width: size.width / 3,
                height: size.height,
                color: Colors.purple[200],
              ),
              Container(
                margin: EdgeInsets.only(top: 100),
                child: ListView(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => chatBotScreen()));
                        },
                        child: testGames(
                          name: AppLocalizations.of(context)!.chatbot,
                          image: "images/screen18Img/chatbot.png",
                        )),

                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
