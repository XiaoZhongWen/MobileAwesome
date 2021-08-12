import 'package:cached_network_image/cached_network_image.dart';
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

  static ImageProvider getImageProvider(String? imageUrl, {String holderImg = 'none'}) {
    if (imageUrl == null || imageUrl.isEmpty == true || imageUrl.length == 0) {
      return getAssetImage(holderImg);
    }
    return CachedNetworkImageProvider(imageUrl);
  }

  static getImagePath(String name, {ImageFormat format = ImageFormat.png}) {
    return 'assets/images/$name.${format.value}';
  }
}