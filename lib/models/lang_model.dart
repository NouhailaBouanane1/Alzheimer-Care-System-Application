import 'package:flutter/material.dart';

class Lang extends ChangeNotifier {
  Locale _lang = const Locale('en');

  Locale? get lang => _lang;

  void changeLangToArabic() {
    _lang = const Locale('ar');
    notifyListeners();
  }

  void changeLangToEnglish() {
    _lang = const Locale('en');
    notifyListeners();
  }
}
