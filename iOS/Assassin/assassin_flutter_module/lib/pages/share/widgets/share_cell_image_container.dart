import 'package:assassin_flutter_module/pages/share/models/image_attachment.dart';
import 'package:flutter/widgets.dart';

class ShareCellImageContainer extends StatefulWidget {
  ShareCellImageContainer({Key key, this.attachments}): super(key: key);
  final List<ImageAttachment> attachments;

  @override
  _ShareCellImageContainerState createState() => _ShareCellImageContainerState();
}

class _ShareCellImageContainerState extends State<ShareCellImageContainer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
