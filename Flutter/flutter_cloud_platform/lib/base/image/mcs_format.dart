enum MCSImageFormat {
  png,
  jpg,
  gif,
  webp
}

extension MCSImageFormatExtension on MCSImageFormat {
  String get value => ['png', 'jpg', 'gif', 'webp'][index];
}