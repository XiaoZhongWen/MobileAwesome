import 'package:flutter/cupertino.dart';
import 'package:flutter_deer/res/constants.dart';
import 'package:shared_preferences_extension/shared_preferences_extension.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? get locale {
    String locale = SpExtension.getString(Constant.locale) ?? "";
    switch (locale) {
      case "zh":
        return const Locale("zh", "CN");
      case "en":
        return const Locale("en", "US");
      default:
        return null;
    }
  }

  void setLocale(String locale) {
    SpExtension.putString(Constant.locale, locale);
    notifyListeners();
  }
}