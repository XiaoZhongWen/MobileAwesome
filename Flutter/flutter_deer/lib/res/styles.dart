import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/Dimens.dart';
import 'package:flutter_deer/res/fd_colors.dart';

class TextStyles {
  static const TextStyle textSize12 = TextStyle(
    fontSize: Dimens.font_sp12,
  );
  static const TextStyle textSize16 = TextStyle(
    fontSize: Dimens.font_sp16,
  );
  static const TextStyle textBold14 = TextStyle(
      fontSize: Dimens.font_sp14,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBold16 = TextStyle(
      fontSize: Dimens.font_sp16,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBold18 = TextStyle(
      fontSize: Dimens.font_sp18,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBold24 = TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.bold
  );
  static const TextStyle textBold26 = TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.bold
  );

  static const TextStyle textGray14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: FdColors.text_gray,
  );
  static const TextStyle textDarkGray14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: FdColors.dark_text_gray,
  );

  static const TextStyle textWhite14 = TextStyle(
    fontSize: Dimens.font_sp14,
    color: Colors.white,
  );

  static const TextStyle text = TextStyle(
      fontSize: Dimens.font_sp14,
      color: FdColors.text,
      // https://github.com/flutter/flutter/issues/40248
      textBaseline: TextBaseline.alphabetic
  );
  static const TextStyle textDark = TextStyle(
      fontSize: Dimens.font_sp14,
      color: FdColors.dark_text,
      textBaseline: TextBaseline.alphabetic
  );

  static const TextStyle textGray12 = TextStyle(
      fontSize: Dimens.font_sp12,
      color: FdColors.text_gray,
      fontWeight: FontWeight.normal
  );
  static const TextStyle textDarkGray12 = TextStyle(
      fontSize: Dimens.font_sp12,
      color: FdColors.dark_text_gray,
      fontWeight: FontWeight.normal
  );

  static const TextStyle textHint14 = TextStyle(
      fontSize: Dimens.font_sp14,
      color: FdColors.dark_unselected_item_color
  );
}