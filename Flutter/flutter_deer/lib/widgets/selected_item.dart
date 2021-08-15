import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/gaps.dart';
import 'package:flutter_deer/res/images.dart';

class SelectedItem extends StatelessWidget {

  const SelectedItem({
    Key? key,
    this.title = '',
    this.content = '',
    this.style,
    this.onTap
  }): super(key: key);

  final String title;
  final String content;
  final TextStyle? style;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.0,
        margin: EdgeInsets.only(left: 16, right: 8.0),
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
              child: Text(content),
            ),
            Gaps.hGap8,
            Images.arrowRight
          ],
        ),
      ),
    );
  }
}