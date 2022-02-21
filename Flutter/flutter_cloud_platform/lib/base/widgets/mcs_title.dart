import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_font.dart';

enum MCSTitleType {
  barTitle,
  listTitleSmall,
  listTitleNormal,
  listSubTitleSmall,
  listSubTitleNormal,
  listInfoTitle,
  cardTitle,
  cardSubTitle,
  btnTitleNormal,
  btnTitleGray
}

class MCSTitle extends StatelessWidget {

  final String title;
  final MCSTitleType? type;

  MCSTitle(this.title, {Key? key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = Colors.black;
    double fontSize = titleFontSize;
    FontWeight fontWeight = titleFontWeight;

    MCSTitleType titleType = type ?? MCSTitleType.barTitle;
    switch (titleType) {
      case MCSTitleType.barTitle:{
        color = Colors.black;
        fontSize = fontLevel4;
        fontWeight = FontWeight.bold;
        break;
      }
      case MCSTitleType.listTitleSmall: {
        color = Colors.black87;
        fontSize = fontLevel1;
        fontWeight = FontWeight.normal;
        break;
      }
      case MCSTitleType.listTitleNormal: {
        color = Colors.black;
        fontSize = fontLevel3;
        fontWeight = FontWeight.normal;
        break;
      }
      case MCSTitleType.listSubTitleSmall: {
        color = Colors.grey;
        fontSize = fontLevel1;
        fontWeight = FontWeight.normal;
        break;
      }
      case MCSTitleType.listSubTitleNormal: {
        color = Colors.grey;
        fontSize = fontLevel2;
        fontWeight = FontWeight.normal;
        break;
      }
      case MCSTitleType.listInfoTitle: {
        color = Colors.white;
        fontSize = fontLevel1;
        fontWeight = FontWeight.normal;
        break;
      }
      case MCSTitleType.cardTitle: {
        color = Colors.black;
        fontSize = fontLevel5;
        fontWeight = FontWeight.normal;
        break;
      }
      case MCSTitleType.cardSubTitle: {
        color = Colors.black;
        fontSize = fontLevel2;
        fontWeight = FontWeight.normal;
        break;
      }
      case MCSTitleType.btnTitleNormal: {
        color = Colors.black;
        fontSize = fontLevel1;
        fontWeight = FontWeight.normal;
        break;
      }
      case MCSTitleType.btnTitleGray: {
        color = Colors.grey;
        fontSize = fontLevel1;
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
