import 'package:assassin_flutter_module/pages/share/models/share_comment.dart';
import 'package:flutter/widgets.dart';

class ShareCellComment extends StatelessWidget {
  ShareCellComment({this.shareComment}): super(key: ValueKey(shareComment.id));

  final ShareComment shareComment;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
