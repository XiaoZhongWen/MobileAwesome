import 'package:flutter/cupertino.dart';

class LineCaculator {
  bool isExceedMaxLines(String text, TextStyle textStyle, int maxLine, double maxWidth) {
    TextSpan textSpan = TextSpan(text: text, style: textStyle);
    TextPainter textPainter = TextPainter(text: textSpan, maxLines: maxLine, textDirection: TextDirection.ltr);
    textPainter.layout(maxWidth: maxWidth);
    // print(textPainter.height);
    if (textPainter.didExceedMaxLines) {
      return true;
    }
    return false;
  }
}