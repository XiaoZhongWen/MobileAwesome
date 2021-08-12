import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/gaps.dart';

class TextFieldItem extends StatelessWidget {

  const TextFieldItem({
    Key? key,
    this.controller,
    this.focusNode,
    this.hintText = '',
    this.title = '',
    this.keyboardType = TextInputType.text
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String hintText;
  final String title;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16.0),
      height: 50.0,
      decoration: BoxDecoration(
        border: Border(
          bottom: Divider.createBorderSide(context, width: 0.6)
        )
      ),
      child: Row(
        children: [
          Text(title),
          Gaps.hGap16,
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              keyboardType: keyboardType,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none
              ),
            )
          ),
          Gaps.hGap16
        ],
      ),
    );
  }
}