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
      this.height,
      this.url, {Key? key,}) : super(key: key);

  String msgId;
  String fileName;
  int width;
  int height;
  String url;

  @override
  _ImageMessageCellState createState() => _ImageMessageCellState();
}

class _ImageMessageCellState extends State<ImageMessageCell> {
  @override
  Widget build(BuildContext context) {
    String path = MCSImageService.singleton.pathForThumbnail(widget.fileName);
    double width = widget.width.toDouble();
    double height = widget.height.toDouble();
    return Stack(
      alignment: Alignment.center,
      children: [
        Selector<IMProvider, int>(
          selector: (_, provider) => provider.fetchMessageStatus(widget.msgId, MessageStatusType.receive),
          shouldRebuild: (prev, next) => prev != next,
          builder: (_, status, __) {
            bool isExist = MCSImageService.singleton.isExist(widget.fileName);
            return ClipRRect(
                borderRadius: imageBorderRadius,
                child: isExist?
                MCSLocalImage(path, width: width, height: height,fit: BoxFit.contain,) :
                Container(
                  color: Colors.grey,
                  width: width,
                  height: height,
                )
            );
          },
        ),
        Selector<IMProvider, int>(
            selector: (_, provider) => provider.fetchMessageStatus(widget.msgId, MessageStatusType.progress),
            shouldRebuild: (prev, next) => prev != next,
            builder: (_, progress, __) {
              int value = MCSImageService.singleton.progress(widget.url);
              if (value == 0) {
                return MCSLoading(progress);
              } else {
                return MCSLoading(value);
              }
            }),
      ],
    );
  }
}
