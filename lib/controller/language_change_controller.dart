import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageChangeController with ChangeNotifier {
  Locale? _appLocale;
  Locale? get appLocale => _appLocale;
  
  Future<void> changeLanguage(Locale type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _appLocale = type;
    print(_appLocale);
    notifyListeners();
    if (type == Locale('en')) {
      await prefs.setString('language_code', 'en');
    } else {
      await prefs.setString('language_code', 'nl');
    }
  }
}
