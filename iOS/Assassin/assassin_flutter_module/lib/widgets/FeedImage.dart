import 'package:assassin_flutter_module/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';

class FeedImage extends StatefulWidget {
  final bool isSingle;
  final String url;
  final Size originalSize;
  final double containerWidth;

  FeedImage({Key key, this.url, this.containerWidth, this.isSingle, this.originalSize}): super(key: key);

  @override
  _FeedImageState createState() => _FeedImageState();
}

class _FeedImageState extends State<FeedImage> {
  @override
  Widget build(BuildContext context) {
    Size size = adjustSize(widget.originalSize, widget.isSingle, widget.containerWidth);
    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.all(widget.isSingle? 0.0: default_margin / 4),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(share_feed_image_radius),
        ),
        child: Image.network(widget.url, fit: widget.isSingle? BoxFit.contain: BoxFit.cover),
      )
    );
  }

  Size adjustSize(Size size, bool isSingle, double containerWidth) {
    if (size.width == 0.0 ||
        size.height == 0.0 ||
        !isSingle) {
      double size = containerWidth / 3;
      return Size(size, size);
    } else {
      double maxW = 150.0;
      double maxH = 150.0;
      double scale = size.width / size.height;
      double width = size.width;
      double height = size.height;
      if (size.width > maxW) {
        width = maxW;
        height = maxW / scale;
      }
      if (size.height > maxH) {
        width = maxH * scale;
        height = maxH;
      }

      double minW = 54.0;
      double minH = 42.0;
      if (width < minW) {
        width = minW;
        height = minW / scale;
      }
      if (height < minH) {
        height = minH;
        width = minH * scale;
      }
      return Size(width, height);
    }
  }
}
