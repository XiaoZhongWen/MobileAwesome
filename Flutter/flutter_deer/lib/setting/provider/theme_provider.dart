import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/constants.dart';
import 'package:shared_preferences_extension/shared_preferences_extension.dart';

/**
 * 创建一个ThemeMode的extension: ThemeModeExtension, 为ThemeMode扩展一个get value方法
 */
extension ThemeModeExtension on ThemeMode {
  String get value => ["System", "Light", "Dark"][index];
}

class ThemeProvider extends ChangeNotifier {
  void syncTheme() {
    String theme = SpExtension.getString(Constant.theme) ?? "";
    if (theme.isNotEmpty && theme != ThemeMode.system.value) {
      notifyListeners();
    }
  }

  void setTheme(ThemeMode themeMode) {
    SpExtension.putString(Constant.theme, themeMode.value);
    notifyListeners();
  }

  ThemeMode getThemeMode() {
    String theme = SpExtension.getString(Constant.theme) ?? "";
    switch (theme) {
      case "Dark":
        return ThemeMode.dark;
      case "Light":
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  ThemeData getTheme({bool isDarkMode = false}) {
    /// TODO 2021-06-12
    return ThemeData();
  }
}