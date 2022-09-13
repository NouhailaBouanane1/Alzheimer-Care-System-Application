import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/ToDo/task_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class tasksTilePatient extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final int index;
  final DateTime date;
  final String time;
  final String docId;
  const tasksTilePatient(
      {required this.isChecked,
      required this.taskTitle,
      required this.time,
      required this.index,
      required this.docId,
      required this.date});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      title: Text(
        taskTitle,
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null,fontSize: 40,fontWeight: FontWeight.bold),
      ),
      subtitle: Text(time + ' - ${date.day}/${date.month}',style: TextStyle(fontSize: 36,fontWeight: FontWeight.w400,color: Colors.deepPurple),),
      trailing: Checkbox(
        activeColor: Colors.purpleAccent,
        value: isChecked,
        onChanged: (val) {
          FirebaseFirestore.instance
              .collection('To Do')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('To Do')
              .doc(docId)
              .set({'checkd': val}, SetOptions(merge: true));
        },
      ),
    );
  }
}
