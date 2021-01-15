import 'dart:convert';

class ImageAttachment {
  List originalImagePath;
  List originalImageHeight;
  List originalImageWidth;

  ImageAttachment({this.originalImageHeight, this.originalImagePath, this.originalImageWidth});

  factory ImageAttachment.fromJson(Map<String, dynamic> map) {
    List imagePath = map["originalImagePath"];
    List imageHeight = map["originalImageHeight"];
    List imageWidth = map["originalImageWidth"];
    return ImageAttachment(
        originalImagePath: imagePath,
        originalImageHeight: imageHeight,
        originalImageWidth: imageWidth
    );
  }
}