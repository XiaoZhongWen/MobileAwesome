class ShareComment {
  String cnname;
  String id;
  String content;
  String headUrl;
  String replier;
  int replierTime;

  ShareComment({this.cnname, this.id, this.content, this.headUrl, this.replier, this.replierTime});

  factory ShareComment.fromJson(Map<String, dynamic> json) {
    return ShareComment(
      cnname: json["cnname"],
      id: json["id"],
      content: json["content"],
      headUrl: json["headUrl"],
      replier: json["replier"],
      replierTime: json["replierTime"]
    );
  }
}