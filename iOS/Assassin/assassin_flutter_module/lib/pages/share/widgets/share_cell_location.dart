import 'package:assassin_flutter_module/constants.dart';
import 'package:assassin_flutter_module/pages/share/models/location_attachment.dart';
import 'package:assassin_flutter_module/pages/share/models/share_callbacks_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_location_attachment_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ShareCellLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShareLocationAttachmentProvider locationAttachmentProvider = Provider.of<ShareLocationAttachmentProvider>(context);
    ShareCallbacksProvider callbacksProvider = Provider.of<ShareCallbacksProvider>(context);
    return Container(
      margin: EdgeInsets.only(left: share_portrait_size + default_margin, top: default_margin),
      child: GestureDetector(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(share_feed_image_radius),
            child: Container(
              color: Colors.grey.shade200,
              padding: EdgeInsets.all(default_margin),
              child: Row(
                children: [
                  Container(child: Icon(Icons.location_on_outlined, color: Colors.grey, size: share_icon_size,), margin: EdgeInsets.only(right: default_margin),),
                  Expanded(
                    child: Text(locationAttachmentProvider.attachment.address, style: TextStyle(color: Colors.grey), overflow: TextOverflow.clip,),
                    flex: 1,
                  )
                ],
              ),
            )
        ),
        onTap: () => callbacksProvider.onTapLocationAttachment(locationAttachmentProvider.index),
      )
    );
  }
}
