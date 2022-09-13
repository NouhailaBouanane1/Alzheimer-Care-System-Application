import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/Emergency/Emergency.dart';
import 'package:graduation_project/chatMessages/chatScreen.dart';
import 'package:graduation_project/mode_model.dart';
import 'package:graduation_project/screen15Patient.dart';
import 'package:graduation_project/share_location.dart';
import 'package:graduation_project/testGames.dart';
import 'package:graduation_project/users_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class screen17Patient extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => screen17PatientState();
}

class screen17PatientState extends State<screen17Patient> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var _userMode = Provider.of<Mode>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purpleAccent,
          title: Text(
            AppLocalizations.of(context)!.emergency,
            style: TextStyle(
              fontWeight: FontWeight.bold,
                fontSize: 29
            ),
          ),
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
                margin: const EdgeInsets.only(top: 100),
                child: ListView(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Emergency()));
                        },
                        child: testGames(
                          name: AppLocalizations.of(context)!.fastmessages,
                          image: "images/screen17Img/emergency.png",
                        )),

                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  ShareLocation()));
                        },
                        child: testGames(
                          name: AppLocalizations.of(context)!.shareLocation,
                          image: "images/screen17Img/shareLocation.png",
                        )),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UsersList(
                                        nav: 'Chat',
                                        userMode: _userMode,
                                        mode: 'nonPatients',
                                      )));
                        },
                        child: testGames(
                          name: AppLocalizations.of(context)!.chat,
                          image: "images/screen17Img/videoCall (2).jpg",
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
