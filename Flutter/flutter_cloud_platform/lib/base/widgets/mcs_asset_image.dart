import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/image/mcs_format.dart';

class MCSAssetImage extends StatelessWidget {
  const MCSAssetImage(this.image, {
    Key? key,
    this.width,
    this.height,
    this.color,
    this.format = MCSImageFormat.png
  }) : super(key: key);

  final String image;
  final double? width;
  final double? height;
  final Color? color;
  final MCSImageFormat format;

  String pathForAssetImage() {
    return 'assets/images/' + image + '.' + format.value;
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      pathForAssetImage(),
      width: width,
      height: height,
      color: color,
    );
  }
}
