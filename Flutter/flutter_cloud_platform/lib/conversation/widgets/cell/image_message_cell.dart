import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_border.dart';
import 'package:flutter_cloud_platform/base/providers/im_provider.dart';
import 'package:flutter_cloud_platform/base/service/mcs_image_service.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_loading.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_local_image.dart';
import 'package:provider/provider.dart';

class ImageMessageCell extends StatefulWidget {
  ImageMessageCell(
      this.msgId,
      this.fileName,
      this.width,
      this.height, {Key? key,}) : super(key: key);

  String msgId;
  String fileName;
  int width;
  int height;

  @override
  _ImageMessageCellState createState() => _ImageMessageCellState();
}

class _ImageMessageCellState extends State<ImageMessageCell> {
  @override
  Widget build(BuildContext context) {
    String path = MCSImageService.singleton.pathForThumbnail(widget.fileName);
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
            borderRadius: imageBorderRadius,
            child: MCSLocalImage(
              path,
              width: widget.width.toDouble(),
              height: widget.height.toDouble(),)
        ),
        Selector<IMProvider, int>(
            selector: (_, provider) => provider.fetchMessageStatus(widget.msgId, MessageStatusType.progress),
            shouldRebuild: (prev, next) => prev != next,
            builder: (_, progress, __) {
              return MCSLoading(progress);
            }),
      ],
    );
  }
}
