import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/Dimens.dart';
import 'package:flutter_deer/res/fd_colors.dart';
import 'package:flutter_deer/res/gaps.dart';
import 'package:flutter_deer/widgets/fd_button.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/util/theme_utils.dart';

class SearchBar extends StatelessWidget implements PreferredSizeWidget {

  SearchBar({
    Key? key,
    this.hintText = '',
    this.onPressed
  }):super(key: key);

  final String hintText;
  final Function(String)? onPressed;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {

    final bool isDark = context.isDark;
    final Color color = isDark? FdColors.dark_text_gray: FdColors.text_gray_c;

    // 1. 返回按钮
    Widget back = SizedBox(
      width: 48.0,
      height: 48.0,
      child: InkWell(
        borderRadius: BorderRadius.circular(24.0),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: LoadAssetImage("ic_back_black", color: isDark?FdColors.dark_text:FdColors.text,),
        ),
        onTap: () {
          _focusNode.unfocus();
          Navigator.maybePop(context);
        },
      ),
    );
    
    // 2. textfield
    Widget textfield = Expanded(
      child: Container(
        height: 32.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            color:isDark?FdColors.dark_material_bg:FdColors.bg_gray
        ),
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              contentPadding: EdgeInsets.only(top: 0.0, left: -8.0, right: -16.0, bottom: 14.0),
              icon: Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0),
                child: LoadAssetImage("order/order_search"),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  _controller.text = "";
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0, top: 8.0, bottom: 8.0),
                  child: LoadAssetImage("order/order_delete"),
                ),
              )
          ),
        ),
      ),
    );

    // 3. search btn
    Widget searchBtn = FdButton(
      minWidth: 44.0,
      minHeight: 32.0,
      fontSize: Dimens.font_sp14,
      radius: 4.0,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      text: "搜索",
      onPressed: () {
        _focusNode.unfocus();
        onPressed?.call(_controller.text);
      },
    );

    return SafeArea(
        child: Row(
          children: [
            back,
            textfield,
            Gaps.hGap8,
            searchBtn,
            Gaps.hGap16
          ],
        )
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(48.0);
}