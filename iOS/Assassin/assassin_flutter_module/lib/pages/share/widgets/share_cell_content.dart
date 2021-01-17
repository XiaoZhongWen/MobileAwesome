import 'package:assassin_flutter_module/constants.dart';
import 'dart:ui';
import 'package:assassin_flutter_module/tools/string_line_caculator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class ShareCellContent extends StatelessWidget {
  ShareCellContent({Key key, this.content}): super(key: key);
  final String content;

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontSize: font_size_level_2,
        color: Colors.black
    );
    bool isOverFlow = LineCaculator().isExceedMaxLines(content, style, 8, MediaQuery.of(context).size.width - share_portrait_size - default_margin);
    return Container(
      padding: EdgeInsets.only(top: default_margin),
      margin: EdgeInsets.only(left: share_portrait_size + default_margin),
      child: Column(
        children: [
          Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: 1,
                child: Linkify(
                  text: content ?? "",
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                  linkStyle: TextStyle(
                    decoration: TextDecoration.none
                  ),
                  style: style,
                  onOpen: (link) => print("Clicked ${link.url}!"),
                )
              ),
            ],
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: isOverFlow?
                      FlatButton(
                          child: Text("全文"),
                          textColor: Colors.blue,
                          minWidth: 0,
                          padding: EdgeInsets.zero,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          onPressed: () => {}
                      )
                      :null
          )
        ],
      ),
    );
  }
}
