import 'package:flutter/material.dart';
import 'package:graduation_project/ToDo/add_task_screen.dart';
import 'package:graduation_project/ToDo/task_data.dart';
import 'package:graduation_project/ToDo/tasks_List.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ToDoMain extends StatelessWidget {
  final String patUid;
  const ToDoMain({Key? key, required this.patUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        title: Text(AppLocalizations.of(context)!.toDoList,style: TextStyle(fontSize: 29),),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purpleAccent,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: addTaskScreen(
                      patUid: patUid,
                    ))),
            isScrollControlled: true,
          );
        },

        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.purple[300],
      body: Container(
        padding: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
           /* Text(
              '${Provider.of<taskData>(context).taskDataa.length} Tasks',
              style: TextStyle(color: Colors.white, fontSize: 36,
                fontWeight: FontWeight.bold,),
            ),*/
            SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: tasksList(
                  patUid: patUid,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
