import 'package:flutter/cupertino.dart';

class StringExtension {
  double widthOf(BuildContext context, String text, TextStyle style) {
    TextPainter painter = TextPainter(
      locale: Localizations.localeOf(context, nullOk: true),
      maxLines: 1,
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: text,
        style: style
      )
    );
    painter.layout(maxWidth: double.infinity);
    return painter.width;
  }
}