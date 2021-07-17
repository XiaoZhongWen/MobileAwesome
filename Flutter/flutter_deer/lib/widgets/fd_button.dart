import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/Dimens.dart';
import 'package:flutter_deer/res/fd_colors.dart';
import 'package:flutter_deer/util/theme_utils.dart';

class FdButton extends StatelessWidget {

  FdButton({
    Key? key,
    this.text = '',
    this.fontSize = Dimens.font_sp18,
    this.textColor,
    this.disabledTextColor,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.minHeight = 48.0,
    this.minWidth = double.infinity,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0),
    this.onPressed,
    this.radius = 2.0,
    this.side = BorderSide.none
  }): super(key: key);

  final String text;
  final double fontSize;
  final Color? textColor;
  final Color? disabledTextColor;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final double? minWidth;
  final double? minHeight;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onPressed;
  final double radius;
  final BorderSide side;

  @override
  Widget build(BuildContext context) {
    final bool isDark = context.isDark;
    return TextButton(
        onPressed: this.onPressed,
        child: Text(
          text, style: TextStyle(fontSize: fontSize),
        ),
        style: ButtonStyle(
          // 文字颜色
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              // 按钮不可用时
              return disabledTextColor ?? (isDark? FdColors.dark_text: FdColors.text_disabled);
            }
            return textColor ?? (isDark? FdColors.dark_button_text: Colors.white);
          }),
          // 背景颜色
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return disabledBackgroundColor ?? (isDark? FdColors.dark_button_disabled: FdColors.button_disabled);
            }
            return backgroundColor ?? (isDark? FdColors.dark_app_main: FdColors.app_main);
          }),
          // 水波纹
          overlayColor: MaterialStateProperty.resolveWith((states) {
            return (textColor ?? (isDark? FdColors.dark_button_text: Colors.white)).withOpacity(0.12);
          }),
          minimumSize: (minWidth == null || minHeight == null)? null: MaterialStateProperty.all<Size>(Size(minWidth!, minHeight!)),
          padding: MaterialStateProperty.all(padding),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          side: MaterialStateProperty.all(side)
        ),
    );
  }
}