import 'package:assassin_flutter_module/constants.dart';
import 'package:assassin_flutter_module/tools/date_transformer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShareCellHeader extends StatefulWidget {
  ShareCellHeader({Key key, this.publishTime, this.publisherName, this.headerUrl}): super(key: key);
  final String headerUrl;
  final String publisherName;
  final int publishTime;

  @override
  _ShareCellHeaderState createState() => _ShareCellHeaderState();
}

class _ShareCellHeaderState extends State<ShareCellHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Flex(
            direction: Axis.horizontal,
            children: [
              Container(
                margin: EdgeInsets.only(right: default_margin),
                child: ClipOval(
                  child: Image.network(
                    widget.headerUrl,
                    width: share_portrait_size,
                    height: share_portrait_size,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  widget.publisherName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: font_size_level_2,
                    fontWeight: font_weight_level_5
                  ),
                ),
              ),
              Container(
                width: share_publisher_time_max_width,
                margin: EdgeInsets.only(left: default_margin),
                child: Text(
                  DateTransformer.shared.sharePublishTime(widget.publishTime),
                  textAlign: TextAlign.right, textWidthBasis: TextWidthBasis.parent,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: font_size_level_1,
                    fontWeight: font_weight_level_5
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
