import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrugProv extends ChangeNotifier {
  // ignore: prefer_final_fields
  List _drugs = [];

  late List<QueryDocumentSnapshot<Object?>> _queryData;

  late CollectionReference _drugsRef;

  final CollectionReference _notificationsRef =
      FirebaseFirestore.instance.collection('scheduledNotifications');

  final User _user = FirebaseAuth.instance.currentUser!;

  late String _patUid;

  List get drugsList => _drugs;

  final Map _images = {
    'drops': 'images/drugs/drops.png',
    'capsules': 'images/drugs/pill.jpg',
    'liquid': 'images/drugs/syrup.jpg',
    'ointment': 'images/drugs/creme.jpg'
  };

  Future initData(String patId, bool isInit) async {
    _patUid = patId;
    if (isInit) {
      _drugsRef = FirebaseFirestore.instance
          .collection('Drugs')
          .doc(patId)
          .collection('Drugs');
    }

    if (_drugs.isNotEmpty) {
      _drugs.clear();
      _queryData.clear();
    }

    var tempData = await _drugsRef.get();

    _queryData = tempData.docs;

    for (int i = 0; i < tempData.size; i++) {
      _drugs.add(tempData.docs[i].data());
    }
    notifyListeners();
  }

  Future addDrug({
    String? date,
    String? name,
    String? type,
    String? duration,
    String? patUid,
    Timestamp? scheduledTime,
  }) async {
    await _drugsRef.add({
      'time': date.toString(),
      'name': name,
      'type': _images[type],
      'duration': duration
    });
    await _notificationsRef.add({
      'senderUid': _user.uid,
      'receiverUid': _patUid,
      'mode': 'Drugs',
      'name': name,
      'time': scheduledTime
    });

    notifyListeners();
    initData(patUid!, false);
  }

  Future deleteDrug(int index, String patUid) async {
    _drugsRef.doc(_queryData[index].id).delete();
    _drugs.removeAt(index);

    notifyListeners();
  }

  void editDrug(int index, String patUid,
      {String? date, String? name, String? type, String? duration}) {
    if (name != null) {
      _drugs[index]['name'] = name;
      notifyListeners();
    }
    if (date != null) {
      _drugs[index]['time'] = date;
      notifyListeners();
    }
    if (type != null) {
      _drugs[index]['type'] = _images[type];
      notifyListeners();
    }
    if (duration != null) {
      _drugs[index]['duration'] = duration;
      notifyListeners();
    }
    _drugsRef.doc(_queryData[index].id).set({
      'time': date.toString(),
      'name': name,
      'type': _images[type],
      'duration': duration
    }, SetOptions(merge: true));
  }
}
