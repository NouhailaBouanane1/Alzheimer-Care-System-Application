import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/ToDo/task_data.dart';
import 'package:graduation_project/reusable_widgets/reusable_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'add_task_screen.dart';

class tasksTile extends StatelessWidget {
  final bool isChecked;
  final String patUid;
  final String TaskTitle;
  final String time;
  final int index;
  final void Function(bool?) checkBoxChenged;
  final DateTime date;
  const tasksTile({
    required this.patUid,
    required this.isChecked,
    required this.TaskTitle,
    required this.checkBoxChenged,
    required this.time,
    required this.index,
    required this.date,
  });
  @override
  Widget build(BuildContext context) {
    var _taskData = Provider.of<taskData>(context, listen: false);
    // TODO: implement build
    return SizedBox(
      child: ListTile(
        title: Text(
          TaskTitle,
          style: TextStyle(fontSize: 38,fontWeight: FontWeight.bold,
              decoration: isChecked ? TextDecoration.lineThrough : null),
        ),
        subtitle: Text(time + ' - ${date.day}/${date.month}',style: TextStyle(fontSize: 36,fontWeight: FontWeight.w400,color: Colors.deepPurple)),
        trailing: Column(
          children: [
            Container(
              width: 80,
              height: 25,
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.edit,

                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.purpleAccent,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => SingleChildScrollView(
                            child: Container(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: addTaskScreen(
                                  patUid: patUid,
                                  edit: _taskData.taskDataa[index]['name'],
                                  index: index,
                                  
                                ))),
                        isScrollControlled: true,
                      );
                    },
                    child: Icon(
                      Icons.edit,
                      size: 18,
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: 80,
              height: 30,
              child: Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.delete,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                      ,
                      color: Colors.red[400],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      try {
                        showLoading(context);
                        await _taskData.deleteTask(index);
                        hideLoading(context);
                      } catch (e) {
                        hideLoading(context);
                        errorDialog(context, AppLocalizations.of(context)!.errorOccuredTryLater,);
                      }
                    },
                    child: Icon(
                      Icons.delete_forever,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
