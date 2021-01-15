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
      child: Row(
        children: [
          Flex(
            children: [
              Image.network(widget.headerUrl),
              Expanded(
                flex: 1,
                child: Text(widget.publisherName),
              ),
              Text(widget.publishTime.toString(), textAlign: TextAlign.right,)
            ],
          )
        ],
      ),
    );
  }
}
