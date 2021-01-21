import 'package:assassin_flutter_module/constants.dart';
import 'package:assassin_flutter_module/pages/share/models/image_attachment.dart';
import 'package:assassin_flutter_module/pages/share/models/share_callbacks_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_image_attachment_provider.dart';
import 'package:assassin_flutter_module/widgets/FeedImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ShareCellImageContainer extends StatefulWidget {
  @override
  _ShareCellImageContainerState createState() => _ShareCellImageContainerState();
}

class _ShareCellImageContainerState extends State<ShareCellImageContainer> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<ShareImageAttachmentProvider, ShareCallbacksProvider>(
      builder: (context, ShareImageAttachmentProvider attachmentProvider, ShareCallbacksProvider callbacksProvider, _) {
        int count =  attachmentProvider.attachment.originalImagePath.length;
        int crossAxisCount = count == four_gong_ge? cross_axis_count_1: cross_axis_count_2;
        double containerWidth = MediaQuery.of(context).size.width - share_portrait_size - 3 * default_margin;
        return Container(
          margin: EdgeInsets.only(left: share_portrait_size + default_margin),
          child: count == 1?
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(right: default_margin, top: default_margin, bottom: default_margin),
              child: GestureDetector(
                child: FeedImage(
                  url: attachmentProvider.attachment.originalImagePath[0],
                  containerWidth: containerWidth,
                  isSingle: count == 1,
                  originalSize: Size(double.parse(attachmentProvider.attachment.originalImageWidth[0]), double.parse(attachmentProvider.attachment.originalImageHeight[0])),
                ),
                onTap: () => callbacksProvider.onTapImageAttachment(attachmentProvider.attachment.originalImagePath, attachmentProvider.index),
              ),
            ),
          )
           :
          GridView.builder(
              shrinkWrap: true,
              itemCount: count,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount
              ),
              itemBuilder: (context, index) {
                String url = attachmentProvider.attachment.originalImagePath[index];
                double width = 0.0;
                double height = 0.0;
                if (index < count) {
                  width = double.parse(attachmentProvider.attachment.originalImageWidth[index]);
                }
                if (index < count) {
                  height = double.parse(attachmentProvider.attachment.originalImageHeight[index]);
                }
                return GestureDetector(
                  child: FeedImage(
                    url: url,
                    containerWidth: containerWidth,
                    isSingle: count == 1,
                    originalSize: Size(width, height),
                  ),
                  onTap: () => callbacksProvider.onTapImageAttachment(attachmentProvider.attachment.originalImagePath, attachmentProvider.index),
                );
              }
          ),
        );
      },
    );
  }
}
