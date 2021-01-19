import 'package:assassin_flutter_module/channels/application_configuration_channel.dart';
import 'package:assassin_flutter_module/constants.dart';
import 'package:assassin_flutter_module/pages/me/models/account.dart';
import 'package:assassin_flutter_module/pages/share/models/share_action_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_header_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ShareCellAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShareActionProvider actionProvider = Provider.of<ShareActionProvider>(context);
    List<IconButton> list = [
      IconButton(icon: Icon(Icons.thumb_up_alt_outlined, size: share_icon_size,), onPressed: () => {}),
      IconButton(icon: Icon(Icons.insert_comment_outlined, size: share_icon_size,), onPressed: () => {}),
      IconButton(icon: Icon(Icons.play_arrow_sharp, size: share_icon_size,), onPressed: () => {})
    ];
    if (actionProvider.isPublisher()) {
      list.removeLast();
      list.insert(0, IconButton(icon: Icon(Icons.delete_outline), onPressed: () => {}));
    }
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: list,
      ),
    );
  }
}

