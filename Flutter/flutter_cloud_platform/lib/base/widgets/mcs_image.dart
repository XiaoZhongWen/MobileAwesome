import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/models/mcs_download_progress.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MCSImage extends StatelessWidget {

  final String imageUrl;
  final Widget Function(BuildContext context, ImageProvider imageProvider)? imageBuilder;
  final Widget Function(BuildContext context, String url)? placeholder;
  final Widget Function(BuildContext context, String url, MCSDownloadProgress progress)? progressIndicatorBuilder;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Alignment alignment;

  MCSImage.cached({
    Key? key,
    required this.imageUrl,
    this.imageBuilder,
    this.placeholder,
    this.progressIndicatorBuilder,
    this.width,
    this.height,
    this.fit,
    this.alignment = Alignment.center
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: imageBuilder,
      placeholder: placeholder,
      progressIndicatorBuilder: progressIndicatorBuilder == null? null: (BuildContext context, String url, DownloadProgress progress) {
        return progressIndicatorBuilder!(context, url, MCSDownloadProgress(progress.originalUrl, progress.totalSize, progress.downloaded));
      },
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
    );
  }

}