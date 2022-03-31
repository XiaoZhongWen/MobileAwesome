class MFile {

  MFile(this.path, {this.width, this.height});

  factory MFile.fromJson(Map map) {
    int? width = map["width"];
    int? height = map["height"];
    String path = map["path"];
    return MFile(path, width: width, height: height);
  }

  int? width;
  int? height;
  String path;
}