import 'package:flutter/material.dart';

enum ImageFormat {
  png,
  jpg,
  gif,
  webp
}

extension ImageFormatExtension on ImageFormat {
  String get value => ['png', 'jpg', 'gif', 'webp'][index];
}

class ImageUtils {
  static ImageProvider getAssetImage(String imageName, {ImageFormat format = ImageFormat.png}) {
    return AssetImage(getImagePath(imageName, format: format));
  }

  static getImagePath(String name, {ImageFormat format = ImageFormat.png}) {
    return 'assets/images/$name.${format.value}';
  }
}