import 'package:assassin_flutter_module/channels/application_configuration_channel.dart';
import 'package:assassin_flutter_module/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShareTextField extends StatelessWidget {
  ShareTextField({this.focusNode});

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Color themeColor = ApplicationConfigurationChannel.shared.fetchThemeColorSync();
    return Container(
      width: width,
      color: Colors.white,
      padding: EdgeInsets.only(left: default_margin, right: default_margin),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(share_feed_image_radius),
              child: Container(
                height: share_text_field_height,
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: default_margin, right: default_margin),
                color: Colors.grey.shade200,
                child: TextField(
                  focusNode: focusNode,
                  cursorColor: themeColor,
                  decoration: InputDecoration.collapsed (),
                ),
              ),
            )
          ),
          Container(
            width: 60,
            margin: EdgeInsets.only(left: default_margin),
            child: FlatButton(
              color: Colors.grey.shade800,
              textColor: Colors.white,
              child: Text("发送"),
              onPressed: () => {focusNode.unfocus()},
            )
          ),
        ],
      )
    );
  }
}
