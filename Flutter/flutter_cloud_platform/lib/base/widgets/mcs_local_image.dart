import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/image/mcs_format.dart';

class MCSLocalImage extends StatelessWidget {
  MCSLocalImage(this.path, {
    Key? key,
    this.width,
    this.height,
    this.color,
    this.fit,
    this.format = MCSImageFormat.png
  }) : super(key: key);

  final String path;
  final double? width;
  final double? height;
  final Color? color;
  final MCSImageFormat format;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    File file = File(path);
    return Image.file(
      file,
      width: width,
      height: height,
      color: color,
      fit: fit,);
  }
}