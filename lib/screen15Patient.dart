import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:graduation_project/Settings/settings.dart';
import 'package:graduation_project/patientRegistrationModel.dart';
import 'package:graduation_project/reusable_widgets/reusable_widget.dart';
import 'package:graduation_project/screen16Patient.dart';
import 'package:graduation_project/screen17Patient.dart';
import 'package:graduation_project/screen18Patient.dart';
import 'package:graduation_project/screen19Patient.dart';
import 'package:graduation_project/screen1Patient.dart';
import 'package:graduation_project/screen20Patient.dart';
import 'package:graduation_project/screen5Patient.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class screen15Patient extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => screen15PatientState();
}

class screen15PatientState extends State<screen15Patient> {
  @override
  Widget build(BuildContext context) {
    //To get user data from firebase auth
    User user = FirebaseAuth.instance.currentUser!;

    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.alzheimerCareSystem,
            style: TextStyle(
              fontSize: 29,
            ),
          ),
          backgroundColor: Colors.purpleAccent,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => settings()));
                },
                icon: const Icon(Icons.settings))
          ],
        ),
        body: Stack(
          children: [
            Opacity(
              opacity: 0.5,
              child: ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  color: Colors.purpleAccent,
                  height:15.8.h,
                ),
              ),
            ),
            /*  ClipPath(
            clipper: WaveClipper(),
            child: Container(
              decoration: BoxDecoration(
                gradient:LinearGradient(colors:[Colors.purple,Colors.purpleAccent],)
              ),
              height: 135,
            ),

          ),*/
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                      // color: Colors.red,
                      height: 8.h,
                      child: Row(
                        children: <Widget>[
                          user.photoURL != null
                              ? CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(user.photoURL!),
                                )
                              : Container(
                                  height: 7.5.h,
                                  width: 8.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Image.asset('images/profile.png'),
                                ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                user.displayName ?? 'UserName',
                                style: const TextStyle(
                                  fontFamily: "Kanit",
                                  fontSize: 27,
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                  SizedBox(
                    height: 3.h,
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 10,
                      primary: false,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => screen16Patient()));
                            },
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  "images/screen15Img/menuP1.svg",
                                  height: 97,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.testAndGames,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontFamily: "Kanit",
                                    fontWeight: FontWeight.bold,

                                    //fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => screen19Patient()));
                            },
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  "images/screen15Img/menuP2.svg",
                                  height: 13.2.h,
                                ),
                                SizedBox(
                                  height: 8.5.h,
                                  width: 50.w,
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .myDailyActivities,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 3.2.h,
                                        fontFamily: "Kanit",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => screen17Patient()));
                            },
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  "images/screen15Img/menuP3.svg",
                                  height: 120,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.emergency,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 27,
                                    fontFamily: "Kanit",
                                    fontWeight: FontWeight.bold,

                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => screen20Patient()));
                            },
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  "images/screen15Img/menuP4.svg",
                                  height: 120,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.aboutYou,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 27,
                                    fontFamily: "Kanit",
                                    fontWeight: FontWeight.bold,

                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => screen18Patient()));
                            },
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  "images/screen15Img/menuPLearn.svg",
                                  height: 13.h,
                                ),
                                SizedBox(
                                  height: 8.8.h,
                                  width: 50.w,
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .learnAboutAlz,
                                      textAlign: TextAlign.center,

                                      style: TextStyle(
                                        fontSize: 3.2.h,
                                        fontFamily: "Kanit",
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => settings()));
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  "images/sett.png",
                                  height: 120,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.settings,
                                  style: const TextStyle(
                                    fontSize: 27,
                                    fontFamily: "Kanit",
                                    fontWeight: FontWeight.bold,

                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    debugPrint(size.width.toString());
    var path = new Path();
    path.lineTo(0, size.height);
    var firstStart = Offset(size.width / 5, size.height);
    var firstEnd = Offset(size.width / 2.25, size.height - 50);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    var secondEnd = Offset(size.width, size.height - 10);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
