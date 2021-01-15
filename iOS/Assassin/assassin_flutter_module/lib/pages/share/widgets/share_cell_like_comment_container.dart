import 'package:assassin_flutter_module/pages/share/models/share_comment.dart';
import 'package:assassin_flutter_module/pages/share/models/share_good.dart';
import 'package:flutter/widgets.dart';

class ShareCellLikeCommentContainer extends StatefulWidget {
  ShareCellLikeCommentContainer({Key key, this.likes, this.shareComment}): super(key: key);
  final List<ShareGood> likes;
  final ShareComment shareComment;

  @override
  _ShareCellLikeCommentContainerState createState() => _ShareCellLikeCommentContainerState();
}

class _ShareCellLikeCommentContainerState extends State<ShareCellLikeCommentContainer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
