class MCSImageElem {

  MCSImageElem({
    this.url,
    this.fileName,
    this.expires,
    this.width,
    this.height});

  factory MCSImageElem.fromJson(Map<String, dynamic> map) {
    String? url = map['url'];
    String? fileName = map['fileName'];
    int? expires = map['expires'];
    int? width = map['width'];
    int? height = map['height'];
    return MCSImageElem(
        url: url,
        fileName: fileName,
        expires: expires,
        width: width,
        height: height);
  }

  Map<String, dynamic> toJson() => {
    'url':url,
    'fileName':fileName,
    'expires':expires,
    'width':width,
    'height':height
  };

  String? url;
  String? fileName;
  int? expires;
  int? width;
  int? height;
}