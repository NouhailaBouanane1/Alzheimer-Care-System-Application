import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/changePassword.dart';
import 'package:graduation_project/screen5Patient.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:graduation_project/screen7Patient.dart';
import 'package:provider/provider.dart';

import '../mode_model.dart';
import '../ressetPassword.dart';

class settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => settingsState();
}

class settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    var _modeProv = Provider.of<Mode>(context, listen: false);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.purple,
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 25, left: 22),
        child: ListView(
          children: [
            Text(
              AppLocalizations.of(context)!.settings,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Colors.black87,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Colors.purpleAccent,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.account,
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.w400),
                )
              ],
            ),
            Divider(
              height: 15,
              thickness: 3,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => changePassword()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.changePassword,
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.w400),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.purpleAccent,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 17,
            ),
            _modeProv.userMode == 'Patients'
                ? Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => screen7Patient()));
                          },
                          child: Text(
                            AppLocalizations.of(context)!.addDoctor,
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Icon(
                          Icons.add,
                          color: Colors.purpleAccent,
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            SizedBox(
              height: 17,
            ),
            _modeProv.userMode == 'Patients'
                ? Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => screen7Patient()));
                          },
                          child: Text(
                            AppLocalizations.of(context)!.addCaregiver,
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w400),
                          ),
                        ),
                        Icon(
                          Icons.add,
                          color: Colors.purpleAccent,
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            SizedBox(
              height: 19,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48.0),
              child: Center(
                child: OutlinedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => screen5Patient()),
                          (root) => false);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.signOut,
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                          color: Colors.black87),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
