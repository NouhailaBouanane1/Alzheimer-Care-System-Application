
import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskPatient extends ChangeNotifier{
  final String name;
  bool isDone;
  TaskPatient({required this.name,this.isDone=false});
  void doneChanged(){
    isDone=!isDone;
  }
}