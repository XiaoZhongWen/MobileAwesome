class MCSAudioElem {

  MCSAudioElem({this.url, this.fileName, this.duration, this.expires});

  factory MCSAudioElem.fromJson(Map<String, dynamic> map) {
    String? url = map['url'];
    String? fileName = map['fileName'];
    int? duration = map['duration'];
    int? expires = map['expires'];
    return MCSAudioElem(url: url, fileName: fileName, duration: duration, expires: expires);
  }

  Map<String, dynamic> toJson() => {
    'url':url,
    'duration':duration,
    'expires':expires,
    'fileName':fileName
  };

  String? url;
  String? fileName;
  int? duration;
  int? expires;
}