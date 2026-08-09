import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocale extends Model {
  AppLocale._private();

  static final AppLocale _shared = AppLocale._private();

  factory AppLocale() => _shared;

  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void changeLanguage({String? languageCode}) {
    if (languageCode != null) {
      _locale = Locale(languageCode);
    } else {
      if (_locale.languageCode == 'en') {
        _locale = Locale('ar');
      } else {
        _locale = Locale('en');
      }
    }

    _saveLanguage(_locale.languageCode);
    Get.updateLocale(_locale);
    notifyListeners();
  }

  bool isArabic() {
    return _locale.languageCode.toLowerCase() == 'ar';
  }

  void _saveLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentLanguage', language);
  }
}
