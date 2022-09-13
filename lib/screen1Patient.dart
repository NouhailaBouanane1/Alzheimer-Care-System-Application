import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/screen2Patient.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'models/lang_model.dart';

class screen1Patient extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => screen1PatientState();
}

class screen1PatientState extends State<screen1Patient> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var _langProv = Provider.of<Lang>(context, listen: true);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            SizedBox(
                height: 40.h,
                width: double.infinity,
                child: Image.asset(
                  "images/s11.jpg",
                  height: double.infinity,
                  fit: BoxFit.contain,
                )),
            Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 1.4.w, right: 3.5.w),
                      child: Text(
                        AppLocalizations.of(context)!.welcome,

                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          fontFamily: "Quintessential",
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        AppLocalizations.of(context)!.getStarted,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 30,
                          letterSpacing: 1.5,
                          fontFamily: "BebasNeue",
                          color: Colors.purple[200],
                        ),
                      ),
                    ),
                  ]),
            ),
            Stack(children: <Widget>[
              Container(
                child: Column(
                  children: [
                    Container(
                      height: 6.7.h,
                      margin: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 20),
                              blurRadius: 15,
                            ),
                          ]),
                      child: Row(children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              AppLocalizations.of(context)!.selectYourLanguage,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                color: Colors.black,
                                fontFamily: "RobotoCondensed",
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            "images/language.png",
                            width: 10.w,
                            height: 10.h,
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 3.h,
                    ), //grey
                    Container(
                      height: 8.h,
                      width: 50.w,
                      color: Colors.purple[200],
                      child: TextButton(
                        child: const Text(
                          "العربية",
                          style: TextStyle(
                            color: Colors.black,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                          ),
                        ),
                        onPressed: () {
                          _langProv.changeLangToArabic();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => screen2Patient()));
                        },
                      ),
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ), //button
                    Container(
                      width: 50.w,
                      height: 8.h,
                      color: Colors.purple[200],
                      child: TextButton(
                        child: const Text(
                          "English",
                          style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 1.5,
                              fontSize: 36,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          if (_langProv.lang!.languageCode != 'en') {
                            _langProv.changeLangToEnglish();
                          }
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => screen2Patient()));
                        },
                      ),
                    ),
//button
                  ],
                ),
                margin: EdgeInsets.only(top: 56.h),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
              ),
            ])
          ],
        ));
  }
}
