import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graduation_project/screen3Patient.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class screen2Patient extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => screen2PatientState();
}

class screen2PatientState extends State<screen2Patient> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(children: <Widget>[
          Container(
              height: 450,
              width: double.infinity,
              child: Image.asset(
                "images/SC22.jpg",
                height: double.infinity,
                fit: BoxFit.fill,
              )),
          Center(
            child: Stack(
              children: <Widget>[
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 14.0, top: 14, right: 14),
                        child: Text(
                          AppLocalizations.of(context)!.alzheimerCareSystem,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                            fontFamily: "Quintessential",
                            letterSpacing: 1.5,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          child: Text(
                            AppLocalizations.of(context)!.screen2Paragraph,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 2,
                              letterSpacing: 1.5,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: FlatButton(
                          padding: EdgeInsets.only(
                              top: 10, left: 80, right: 80, bottom: 10),
                          color: Colors.purple,
                          child: Text(
                            AppLocalizations.of(context)!.start,
                            style: const TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.5,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => screen3Patient()));
                          },
                        ),
                      ),
                    ],
                  ),
                  height: size.height * 0.5,
                  margin: EdgeInsets.only(top: 400),
                  decoration: BoxDecoration(
                      color: Color(0xffF3E5F5),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50))
//button
                      ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
