import 'package:flutter/material.dart';
import 'package:graduation_project/ToDoPatient/task_Patient.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class taskDataPatient extends ChangeNotifier{
  List<TaskPatient> tasks=[];

  void updateTask(TaskPatient task){
    task.doneChanged();
    notifyListeners();
  }
}