import 'package:assassin_flutter_module/constants.dart';
import 'package:assassin_flutter_module/pages/share/models/share_action_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_callbacks_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ShareCellAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShareActionProvider actionProvider = Provider.of<ShareActionProvider>(context);
    ShareCallbacksProvider callbacksProvider = Provider.of<ShareCallbacksProvider>(context);
    Key key = Provider.of<Key>(context);
    int index = actionProvider.index;
    List<IconButton> list = [
      IconButton(icon: Icon(Icons.thumb_up_alt_outlined, size: share_icon_size,), onPressed: () => callbacksProvider.giveLike(index)),
      IconButton(icon: Icon(Icons.insert_comment_outlined, size: share_icon_size,), onPressed: () => callbacksProvider.onTapComment(context, index, key)),
      IconButton(icon: Icon(Icons.play_arrow_sharp, size: share_icon_size,), onPressed: () => callbacksProvider.retransmit(index))
    ];
    if (actionProvider.isPublisher()) {
      list.removeLast();
      list.insert(0, IconButton(icon: Icon(Icons.delete_outline), onPressed: () => callbacksProvider.delete(index)));
    }

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: list,
      ),
    );
  }
}

