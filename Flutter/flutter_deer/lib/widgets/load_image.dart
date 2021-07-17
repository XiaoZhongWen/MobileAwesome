import 'package:flutter/cupertino.dart';
import 'package:flutter_deer/util/image_utils.dart';

class LoadAssetImage extends StatelessWidget {
  final String imageName;
  final double? width;
  final double? height;
  final int? cacheWidth;
  final int? cacheHeight;
  final BoxFit? fit;
  final Color? color;
  final ImageFormat format;

  const LoadAssetImage(this.imageName, {
    Key? key,
    this.width,
    this.height,
    this.cacheWidth,
    this.cacheHeight,
    this.fit,
    this.color,
    this.format = ImageFormat.png}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageUtils.getImagePath(this.imageName, format: this.format),
      width: this.width,
      height: this.height,
      cacheWidth: this.cacheWidth,
      cacheHeight: this.cacheHeight,
      fit: this.fit,
      color: this.color,
    );
  }
}