import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/ToDo/task_data.dart';
import 'package:graduation_project/ToDoPatient/task_Tile_Patient.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../reusable_widgets/reusable_widget.dart';

class tasksListPatient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _user = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('To Do')
            .doc(_user.uid)
            .collection('To Do')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            var tempList = snapshot.data!.docs;
            List data = [];
            for (var element in tempList) {
              data.add(element.data());
            }

            return data.isNotEmpty
                ? ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return tasksTilePatient(
                        isChecked: data[index]['checkd'],
                        taskTitle: data[index]['name'],
                        index: index,
                        date: data[index]['date'].toDate(),
                        time: data[index]['time'],
                        docId: snapshot.data!.docs[index].id,
                      );
                    },
                  )
                : Center(
                    child: Text(AppLocalizations.of(context)!.noTasksYet,style: TextStyle(fontSize: 36),),
                  );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(color: Colors.purpleAccent);
          } else if (snapshot.hasError) {
            errorDialog(context, AppLocalizations.of(context)!.errorOccuredTryLater,);
            return const SizedBox();
          } else {
            return const SizedBox();
          }
        });
  }
}
