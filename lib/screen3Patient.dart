import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/screen16Patient.dart';
import 'package:graduation_project/screen4Patient.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class screen3Patient extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => screen3PatientState();
}

class screen3PatientState extends State<screen3Patient> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Opacity(
              opacity: 0.6,
              child: Image.asset(
                "images/sc3b.jpg",
                height: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: FlatButton(
                    padding: EdgeInsets.all(25),
                    color: Colors.purple[200],
                    child: Text(
                      AppLocalizations.of(context)!.loginOrCreateAccount,
                      style: TextStyle(
                          fontSize: 34,
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => screen4Patient()));
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
                    color: Colors.white,
                    child: Text(
                      AppLocalizations.of(context)!.takeTestsAndPlayGames,
                      style: TextStyle(
                          fontSize: 34,
                          color: Colors.purple[200],
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => screen16Patient()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
