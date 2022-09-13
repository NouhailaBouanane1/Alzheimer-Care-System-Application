import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/ToDoPatient/ToDoMainPatient.dart';
import 'package:graduation_project/reusable_widgets/reusable_widget.dart';
import 'package:graduation_project/screen15Patient.dart';
import 'package:graduation_project/testGames.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'drugReminder/patient_page.dart';
import 'mode_model.dart';

class screen19Patient extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => screen19PatientState();
}

class screen19PatientState extends State<screen19Patient> {
  @override
  Widget build(BuildContext context) {
    var _userMode = Provider.of<Mode>(context, listen: false);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.myDailyActivities,
            style: TextStyle(fontSize: 29
                , fontWeight: FontWeight.bold),
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
                        onTap: () async {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PatientDrugHome()));
                        },
                        child: testGames(
                          name: AppLocalizations.of(context)!.drugs,

                          image: "images/screen19Img/drugs (2).jpg",
                        )),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ToDoMainPatient()));
                        },
                        child: testGames(
                          name:AppLocalizations.of(context)!.toDoList,
                          image: "images/screen19Img/toDoList.png",
                        )),

                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future getData(Mode prov) async {
    var tempData = await FirebaseFirestore.instance
        .collection(prov.userMode!)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    String docUid = tempData['doctorId'];
    return docUid;
  }
}
