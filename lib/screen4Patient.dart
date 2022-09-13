import 'dart:ui';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:graduation_project/screen5Patient.dart';
import 'package:provider/provider.dart';

import 'mode_model.dart';

class screen4Patient extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => screen4PatientState();
}

class screen4PatientState extends State<screen4Patient> {
  @override
  Widget build(BuildContext context) {
    var _modeProv = Provider.of<Mode>(context, listen: false);
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
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Image.asset("images/pu.webp"),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: FlatButton(
                      padding: EdgeInsets.all(25),
                      color: Colors.purpleAccent,
                      child: Text(
                        AppLocalizations.of(context)!.patient,
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        _modeProv.setMode('Patients');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => screen5Patient()));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: FlatButton(
                      padding: EdgeInsets.all(25),
                      color: Colors.purpleAccent,
                      child: Text(
                        AppLocalizations.of(context)!.caregiver,
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        _modeProv.setMode('Caregiver');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => screen5Patient()));
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: FlatButton(
                      padding: EdgeInsets.all(25),
                      color: Colors.purpleAccent,
                      child: Text(
                        AppLocalizations.of(context)!.doctor,
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.bold),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        _modeProv.setMode('Doctors');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => screen5Patient()));
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

