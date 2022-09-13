import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mode extends ChangeNotifier {
  String? _mode;

  CollectionReference? _collectionRefMode;

  String? get userMode => _mode;

  CollectionReference? get collectionRefMode => _collectionRefMode;

  Future setMode(String mode) async {
    _mode = mode;
    _collectionRefMode = FirebaseFirestore.instance.collection(mode);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('mode', mode);
  }

  Future<String> getMode() async {
    final prefs = await SharedPreferences.getInstance();
    String? mode = prefs.getString('mode');
    if (mode != null) {
      _mode = mode;
      _collectionRefMode = FirebaseFirestore.instance.collection(mode);
      notifyListeners();
    }
    return mode ?? "";
  }
}
