import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/constants.dart';
import 'package:flutter_deer/res/fd_colors.dart';
import 'package:flutter_deer/res/styles.dart';
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
    return ThemeData(
      errorColor: isDarkMode ? FdColors.dark_red : FdColors.red,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primaryColor: isDarkMode ? FdColors.dark_app_main : FdColors.app_main,
      accentColor: isDarkMode ? FdColors.dark_app_main : FdColors.app_main,
      // Tab指示器颜色
      indicatorColor: isDarkMode ? FdColors.dark_app_main : FdColors.app_main,
      // 页面背景色
      scaffoldBackgroundColor: isDarkMode ? FdColors.dark_bg_color : Colors.white,
      // 主要用于Material背景色
      canvasColor: isDarkMode ? FdColors.dark_material_bg : Colors.white,
      // 文字选择色（输入框选择文字等）
      // textSelectionColor: FdColors.app_main.withAlpha(70),
      // textSelectionHandleColor: FdColors.app_main,
      // 稳定版：1.23 变更(https://flutter.dev/docs/release/breaking-changes/text-selection-theme)
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: FdColors.app_main.withAlpha(70),
        selectionHandleColor: FdColors.app_main,
        cursorColor: FdColors.app_main,
      ),
      textTheme: TextTheme(
        // TextField输入文字颜色
        subtitle1: isDarkMode ? TextStyles.textDark : TextStyles.text,
        // Text文字样式
        bodyText2: isDarkMode ? TextStyles.textDark : TextStyles.text,
        subtitle2: isDarkMode ? TextStyles.textDarkGray12 : TextStyles.textGray12,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: isDarkMode ? TextStyles.textHint14 : TextStyles.textDarkGray14,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: isDarkMode ? FdColors.dark_bg_color : Colors.white,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      dividerTheme: DividerThemeData(
          color: isDarkMode ? FdColors.dark_line : FdColors.line,
          space: 0.6,
          thickness: 0.6
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      // pageTransitionsTheme: NoTransitionsOnWeb(),
      visualDensity: VisualDensity.standard,  // https://github.com/flutter/flutter/issues/77142
    );
  }
}