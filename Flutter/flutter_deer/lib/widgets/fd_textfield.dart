import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/gaps.dart';
import 'package:flutter_deer/widgets/load_image.dart';

class FdTextField extends StatefulWidget {

  const FdTextField({
    Key? key,
    required this.controller,
    this.maxLength = 16,
    this.focusNode,
    this.hintText = '',
    this.keyboardType = TextInputType.text,
    this.isPwd = false
  }): super(key: key);

  final int maxLength;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String hintText;
  final TextInputType keyboardType;
  final bool isPwd;

  _FdTextFieldState createState() => _FdTextFieldState();
}

class _FdTextFieldState extends State<FdTextField> {
  bool _isShowPwd = false;
  bool _isShowDelete = false;

  @override
  void initState() {
    widget.controller.addListener(isEmpty);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(isEmpty);
    super.dispose();
  }

  void isEmpty() {
    final bool isNotEmpty = widget.controller.text.isNotEmpty;
    if (isNotEmpty != _isShowDelete) {
      setState(() {
        _isShowDelete = isNotEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    final ThemeData themeData = Theme.of(context);
    final bool isDark = themeData.brightness == Brightness.dark;

    Widget textField = TextField(
      controller: widget.controller,
      maxLength: widget.maxLength,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPwd && !_isShowPwd,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: widget.hintText,
        counterText: '',
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).dividerTheme.color!,
            width: 0.8
          )
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: themeData.primaryColor,
            width: 0.8
          )
        )
      ),
    );

    Widget clearButton = GestureDetector(
      child: LoadAssetImage(
        "login/qyg_shop_icon_delete",
        key: Key("qyg_shop_icon_delete"),
        width: 18.0,
        height: 40.0,
      ),
      onTap: () {
        widget.controller.text = '';
      },
    );

    Widget pwdVisible = GestureDetector(
      child: LoadAssetImage(
        _isShowPwd?"login/qyg_shop_icon_display":"login/qyg_shop_icon_hide",
        key: Key(_isShowPwd?"qyg_shop_icon_display":"qyg_shop_icon_hide"),
        width: 18.0,
        height: 40.0,
      ),
      onTap: () {
        setState(() {
          _isShowPwd = !_isShowPwd;
        });
      },
    );

    return Stack(
      alignment: Alignment.centerRight,
      children: [
        textField,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _isShowDelete?clearButton:Gaps.empty,
            widget.isPwd?Gaps.hGap15:Gaps.empty,
            widget.isPwd?pwdVisible:Gaps.empty
          ],
        ),
      ],
    );
  }
}