import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/ToDo/task_data.dart';
import 'package:graduation_project/ToDoPatient/tasks_List_Patient.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../reusable_widgets/reusable_widget.dart';

class ToDoMainPatient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _user = FirebaseAuth.instance.currentUser!;
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child:
                Icon(Icons.arrow_back_ios_new, color: Colors.white)),
            Row(
              children: [
                Icon(
                  Icons.playlist_add_check,
                  size: 40,
                  color: Colors.white,
                ),
                SizedBox(width: 20),
                Text(
                  AppLocalizations.of(context)!.toDoList,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('To Do')
                    .doc(_user.uid)
                    .collection('To Do')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data!.size.toString() +AppLocalizations.of(context)!.tasks,
                      style: TextStyle(color: Colors.white, fontSize: 36),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator(
                        color: Colors.purpleAccent);
                  } else {
                    return Text(
                      '0' + AppLocalizations.of(context)!.tasks,
                      style: TextStyle(color: Colors.white, fontSize: 36),
                    );
                  }
                }),
            SizedBox(height: 14),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: tasksListPatient(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
