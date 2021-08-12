import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_deer/res/Dimens.dart';
import 'package:flutter_deer/res/fd_colors.dart';
import 'package:flutter_deer/res/gaps.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/fd_button.dart';
import 'package:flutter_deer/widgets/load_image.dart';

class FDAppBar extends StatelessWidget implements PreferredSizeWidget {

  const FDAppBar({
    Key? key,
    this.backgroundColor,
    this.title = '',
    this.centerTitle = '',
    this.actionName = '',
    this.backImg = 'ic_back_black',
    this.backImgColor,
    this.onPressed,
    this.isBack = true
  }): super(key: key);

  final Color? backgroundColor;
  final String title;
  final String centerTitle;
  final String actionName;
  final String backImg;
  final Color? backImgColor;
  final VoidCallback? onPressed;
  final bool isBack;

  @override
  Widget build(BuildContext context) {
    final Color _color = backgroundColor ?? context.backgroundColor;
    final SystemUiOverlayStyle _overlayStyle = ThemeData.estimateBrightnessForColor(_color) == Brightness.dark
        ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

    final Widget back = isBack?
        IconButton(
            icon: LoadAssetImage(backImg),
            padding: EdgeInsets.all(12.0),
            color: backgroundColor ?? ThemeUtils.getIconColor(context),
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.maybePop(context);
            }):
        Gaps.empty;

    final Widget action = actionName.isNotEmpty? Positioned(
      right: 0.0,
      child: Theme(
        data: Theme.of(context).copyWith(
          buttonTheme: const ButtonThemeData(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            minWidth: 60.0
          )
        ),
        child: FdButton(
          key: const Key('actionName'),
          fontSize: Dimens.font_sp14,
          minWidth: null,
          text: actionName,
          textColor: context.isDark? FdColors.dark_text: FdColors.text,
          backgroundColor: Colors.transparent,
          onPressed: onPressed,
        ),
      ),
    ): Gaps.empty;

    final Widget titleWidget = Semantics(
      namesRoute: true,
      header: true,
      child: Container(
        alignment: centerTitle.isEmpty? Alignment.centerLeft: Alignment.center,
        width: double.infinity,
        child: Text(
          title.isEmpty? centerTitle: title,
          style: const TextStyle(fontSize: Dimens.font_sp18),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 48.0),
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Material(
        color: _color,
        child: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              titleWidget,
              back,
              action
            ],
          ),
        )
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48.0);
}