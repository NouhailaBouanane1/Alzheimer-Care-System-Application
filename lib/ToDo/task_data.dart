import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';

class taskData extends ChangeNotifier {
  List _tasks = [];
  late List<QueryDocumentSnapshot<Object?>> _queryData;
  CollectionReference _toDoRef = FirebaseFirestore.instance.collection('To Do');

  final User _user = FirebaseAuth.instance.currentUser!;

  late String _patUid;

  final CollectionReference _notificationsRef =
      FirebaseFirestore.instance.collection('scheduledNotifications');

  List get taskDataa => _tasks;

  Future initData(String patUid, bool isInit) async {
    _patUid = patUid;
    if (isInit) {
      _toDoRef = FirebaseFirestore.instance
          .collection('To Do')
          .doc(patUid)
          .collection('To Do');
      notifyListeners();
    }
    if (_tasks.isNotEmpty) {
      _tasks.clear();
      _queryData.clear();
    }

    var tempData = await _toDoRef.get();

    _queryData = tempData.docs;

    for (int i = 0; i < tempData.size; i++) {
      _tasks.add(tempData.docs[i].data());
    }
    notifyListeners();
  }

  Future addTask(
    String newTaskTitle,
    String time,
    DateTime date,
    Timestamp scheduledTime,
  ) async {
    await _toDoRef.add(
        {'name': newTaskTitle, 'time': time, 'checkd': false, 'date': date});

    await _notificationsRef.add({
      'senderUid': _user.uid,
      'receiverUid': _patUid,
      'mode': 'To Do',
      'name': newTaskTitle,
      'time': scheduledTime
    });

    await initData('', false);
    notifyListeners();
  }

  Future updateTask(
      int index, String newTitle, String time, DateTime date) async {
    if (_tasks[index] !=
        {'name': newTitle, 'time': time, 'checkd': false, 'date': date}) {
      _tasks[index] = {
        'name': newTitle,
        'time': time,
        'checkd': false,
        'date': Timestamp.fromDate(date)
      };
    }
    await _toDoRef.doc(_queryData[index].id).set(
        {'name': newTitle, 'time': time, 'checkd': false, 'date': date},
        SetOptions(merge: true));
    notifyListeners();
  }

  void onCheck(int index, bool val) {
    if (val) {
      _tasks[index]['checkd'] = true;
    } else {
      _tasks[index]['checkd'] = false;
    }
    notifyListeners();
  }

  Future deleteTask(int index) async {
    await _toDoRef.doc(_queryData[index].id).delete();
    _tasks.removeAt(index);
    notifyListeners();
  }
}
