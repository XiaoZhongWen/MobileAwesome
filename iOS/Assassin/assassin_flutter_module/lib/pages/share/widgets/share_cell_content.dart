import 'package:assassin_flutter_module/constants.dart';
import 'package:assassin_flutter_module/pages/share/models/share_callbacks_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_content_provider.dart';
import 'dart:ui';
import 'package:assassin_flutter_module/tools/string_line_caculator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:provider/provider.dart';

class ShareCellContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontSize: font_size_level_2,
        color: Colors.black
    );

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
                child: Consumer2<ShareContentProvider, ShareCallbacksProvider>(
                  builder: (context, ShareContentProvider shareContentProvider, ShareCallbacksProvider callbacksProvider, _) => Linkify(
                    text: shareContentProvider.content ?? "",
                    maxLines: shareContentProvider.isShowDetail == false? share_content_maxline: share_content_line_infinite,
                    overflow: TextOverflow.ellipsis,
                    linkStyle: TextStyle(
                        decoration: TextDecoration.none
                    ),
                    style: style,
                    onOpen: (link) => callbacksProvider.onTapWebLink(link.url),
                  ),
                )
              ),
            ],
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Consumer2<ShareContentProvider, ShareCallbacksProvider>(
                  builder: (context, ShareContentProvider shareContentProvider, ShareCallbacksProvider callbacksProvider, _) {
                    String content = shareContentProvider.content;
                    bool isOverFlow = LineCaculator().isExceedMaxLines(content, style, share_content_maxline, MediaQuery.of(context).size.width - share_portrait_size - default_margin);
                    if (isOverFlow) {
                      return FlatButton(
                          child: Text(shareContentProvider.isShowDetail == false? "全文": "收起"),
                          textColor: Colors.blue,
                          minWidth: 0,
                          padding: EdgeInsets.zero,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          onPressed: () => callbacksProvider.switchContentDisplayState(shareContentProvider.index)
                      );
                    } else {
                      return Container();
                    }
                  }
              )
          )
        ],
      ),
    );
  }
}
