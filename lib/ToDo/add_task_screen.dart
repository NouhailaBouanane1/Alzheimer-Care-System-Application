import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:graduation_project/ToDo/task_data.dart';
import 'package:graduation_project/reusable_widgets/reusable_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class addTaskScreen extends StatefulWidget {
  String? edit;
  int? index;
  String patUid;
  addTaskScreen({this.edit, Key? key, this.index, required this.patUid})
      : super(key: key);

  @override
  State<addTaskScreen> createState() => _addTaskScreenState();
}

class _addTaskScreenState extends State<addTaskScreen> {
  DateTime? newDate;

  TimeOfDay? newTime;

  DateTime datetime = DateTime.now();

  TextEditingController cont = TextEditingController();
  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  @override
  void initState() {
    super.initState();
    if (widget.edit != null) {
      cont.text = widget.edit!;
      SchedulerBinding.instance?.addPostFrameCallback((_) {
        newTime = stringToTimeOfDay(
            Provider.of<taskData>(context, listen: false)
                .taskDataa[widget.index!]['time']);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    cont.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tasks = Provider.of<taskData>(context, listen: false);
    if (widget.edit != null) {}
    // TODO: implement build
    String? newTaskTitle;
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.addTask,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.purpleAccent),
            ),
            trailing: InkWell(
              child: Icon(Icons.calendar_today_outlined),
              onTap: () async {
                newDate = await showDatePicker(
                    context: context,
                    initialDate: datetime,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100));
                if (newDate == null) return;

                newTime = await showTimePicker(
                  context: context,
                  initialTime:
                      TimeOfDay(hour: datetime.hour, minute: datetime.minute),
                );
                if (newTime == null) return;
              },
            ),
          ),
          TextField(
            style: TextStyle(
              fontSize:36,
            ),
            controller: cont,
            autofocus: true,
            textAlign: TextAlign.center,
            onChanged: (newText) {
              newTaskTitle = newText;
            },
          ),
          const SizedBox(
            height: 36,
          ),
          TextButton(
            onPressed: () async {
              if (widget.edit == null) {
                try {
                  showLoading(context);
                  await tasks.addTask(
                      cont.text,
                      '${newTime?.hourOfPeriod}:${newTime?.minute} ${(newTime?.period.toString().split('.')[1])!.toUpperCase()}',
                      newDate ?? DateTime.now(),
                      Timestamp.fromDate(newDate!));
                  hideLoading(context);
                  Navigator.pop(context);
                } catch (e) {
                  hideLoading(context);
                  errorDialog(context, AppLocalizations.of(context)!.errorOccuredTryLater,);
                }
              } else {
                try {
                  showLoading(context);
                  await tasks.updateTask(
                      widget.index!,
                      cont.text,
                      '${newTime?.hourOfPeriod}:${newTime?.minute} ${(newTime?.period.toString().split('.')[1])!.toUpperCase()}',
                      newDate ?? DateTime.now());
                  hideLoading(context);
                  Navigator.pop(context);
                } catch (e) {
                  hideLoading(context);
                  errorDialog(context, AppLocalizations.of(context)!.errorOccuredTryLater,);
                }
              }
            },
            child: Text(AppLocalizations.of(context)!.add,style: TextStyle(fontSize: 44),),
            style: TextButton.styleFrom(
              backgroundColor: Colors.purpleAccent,
              primary: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
