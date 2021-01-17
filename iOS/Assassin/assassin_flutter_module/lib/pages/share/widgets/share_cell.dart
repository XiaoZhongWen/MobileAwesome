import 'package:assassin_flutter_module/constants.dart';
import 'package:assassin_flutter_module/pages/share/models/share_item.dart';
import 'package:assassin_flutter_module/pages/share/widgets/share_cell_content.dart';
import 'package:assassin_flutter_module/pages/share/widgets/share_cell_header.dart';
import 'package:flutter/widgets.dart';

class ShareCell extends StatefulWidget {
  ShareItem shareItem;

  ShareCell({this.shareItem}): super(key: ValueKey(shareItem.id));

  @override
  _ShareCellState createState() => _ShareCellState();
}

class _ShareCellState extends State<ShareCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(default_margin),
      child: Column(
        children: [
          ShareCellHeader(
            publisherName: widget.shareItem.publisherName,
            publishTime: widget.shareItem.publishTime,
            headerUrl: widget.shareItem.headUrl,
          ),
          ShareCellContent(content: widget.shareItem.content,),

        ],
      ),
    );
  }
}
