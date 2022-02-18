class MCSTextElem {

  MCSTextElem(this.text);

  factory MCSTextElem.fromJson(Map<String, dynamic> map) {
    String text = map['text'];
    return MCSTextElem(text);
  }

  Map<String, dynamic> toJson() => {'text':text};

  String text;
}