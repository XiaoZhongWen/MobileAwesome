import 'package:flutter/material.dart';
import '../constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_setting.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData getTheme() {
    final primaryOrWhite = themeMode == Brightness.light? MCSColors.mainColor: Colors.white;
    final blackOrWhite = themeMode == Brightness.light? Colors.black54: Colors.white;
    return ThemeData(
      primaryColor: MCSColors.mainColor,
      brightness: themeMode,
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black
        )
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: MCSColors.mainColor
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(MCSColors.mainColor),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: roundBorderRadius
          ))
        )
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        contentPadding: MCSLayout.inputContentPadding,
        fillColor: Color.alphaBlend(primaryOrWhite.withOpacity(.07), Colors.grey.withOpacity(.04)),
        labelStyle: TextStyle(color: blackOrWhite),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        enabledBorder:OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: roundBorderRadius
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.transparent),
          borderRadius: roundBorderRadius
        ),
        disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: roundBorderRadius
        ),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
            borderRadius: roundBorderRadius
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
            borderRadius: roundBorderRadius
        ),
      ),
      textTheme: const TextTheme(
        button: TextStyle(color: Colors.white)
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: MCSColors.mainColor,
        shape: StadiumBorder(),
        elevation: 4.0
      )
    );
  }
}