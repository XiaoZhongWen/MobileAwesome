import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/gaps.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/load_image.dart';

class FDAppBar extends StatelessWidget implements PreferredSizeWidget {

  const FDAppBar({
    Key? key,
    this.backgroundColor,
    this.title = '',
    this.centerTitle = '',
    this.actionName = '',
    this.backImg = 'ic_back_black.png',
    this.backImgColor,
    this.onPress,
    this.isBack = true
  }): super(key: key);

  final Color? backgroundColor;
  final String title;
  final String centerTitle;
  final String actionName;
  final String backImg;
  final Color? backImgColor;
  final VoidCallback? onPress;
  final bool isBack;

  @override
  Widget build(BuildContext context) {

    final _color = backgroundColor ?? context.backgroundColor;

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



    return Center();
  }

  @override
  Size get preferredSize => Size.fromHeight(48.0);
}