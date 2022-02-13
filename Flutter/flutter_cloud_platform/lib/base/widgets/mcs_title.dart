import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_font.dart';

enum MCSTitleType {
  small,
  list,
  profile
}

class MCSTitle extends StatelessWidget {

  final String title;
  final MCSTitleType? type;

  const MCSTitle(this.title, {Key? key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Colors.black;
    double fontSize = titleFontSize;
    FontWeight fontWeight = titleFontWeight;

    MCSTitleType titleType = type ?? MCSTitleType.list;
    switch (titleType) {
      case MCSTitleType.small:{
        color = Colors.black87;
        fontSize = fontLevel1;
        fontWeight = FontWeight.normal;
        break;
      }
      case MCSTitleType.list: {
        color = Colors.black;
        fontSize = titleFontSize;
        fontWeight = titleFontWeight;
        break;
      }
      case MCSTitleType.profile: {
        color = Colors.black87;
        fontSize = fontLevel5;
        fontWeight = FontWeight.normal;
        break;
      }
    }

    return Text(title,
      style: TextStyle(
        color: color,
        overflow: TextOverflow.ellipsis,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
      maxLines: 1,
    );
  }
}
