import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/ToDo/task_Tile.dart';
import 'package:graduation_project/ToDo/task_data.dart';
import 'add_task_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';

import 'task_data.dart';

class tasksList extends StatelessWidget {
  final String patUid;
  const tasksList({Key? key, required this.patUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<taskData>(builder: (context, model, _) {
      return ListView.builder(
          itemCount: model.taskDataa.length,
          itemBuilder: (context, index) {
            return tasksTile(
                patUid: patUid,
                isChecked: model.taskDataa[index]['checkd'],
                TaskTitle: model.taskDataa[index]['name'],
                time: model.taskDataa[index]['time'],
                index: index,
                checkBoxChenged: (bool? newValue) {},
                date: model.taskDataa[index]['date'].toDate());
          });
    });
  }
}
