class ShareGood {
  String cnname;
  String headUrl;
  String replier;
  int replierTime;

  ShareGood({this.cnname, this.headUrl, this.replier, this.replierTime});

  factory ShareGood.fromJson(Map<String, dynamic> json) {
    return ShareGood(
      cnname: json["cnname"],
      headUrl: json["headUrl"],
      replier: json["replier"],
      replierTime: json["replierTime"]
    );
  }
}