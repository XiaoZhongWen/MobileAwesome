import 'dart:convert';
import 'package:assassin_flutter_module/pages/share/models/disk_attachment.dart';
import 'package:assassin_flutter_module/pages/share/models/image_attachment.dart';
import 'package:assassin_flutter_module/pages/share/models/location_attachment.dart';
import 'package:assassin_flutter_module/pages/share/models/share_comment.dart';
import 'package:assassin_flutter_module/pages/share/models/share_good.dart';

class ShareItem {
  String id;
  String headUrl;
  List<ShareComment> comments;
  bool showVisible;
  int type;
  List<dynamic> files;
  String publisher;
  bool isPublicAccount;
  String publisherName;
  int publishTime;
  List<ShareGood> goods;
  String content;

  ShareItem({this.id,
    this.headUrl,
    this.comments,
    this.showVisible,
    this.type,
    this.files,
    this.publisher,
    this.isPublicAccount,
    this.publisherName,
    this.publishTime,
    this.goods,
    this.content});

  factory ShareItem.fromJson(Map<String, dynamic> map) {
    List<ShareComment> comments = List();
    List<ShareGood> goods = List();
    List list = map["comments"] ?? List();
    List files = List();
    for(int i = 0; i < list.length; i++) {
      ShareComment comment = ShareComment.fromJson(list[i]);
      comments.add(comment);
    }
    list = map["goods"] ?? List();
    for(int i = 0; i < list.length; i++) {
      ShareGood good = ShareGood.fromJson(list[i]);
      goods.add(good);
    }
    list = map["files"] ?? List();
    for(int i = 0; i < list.length; i++) {
      String jsonStr = list[i];
      Map attachment = json.decode(jsonStr);
      if (attachment["imageAttachment"] != null) {
        ImageAttachment imageAttachment = ImageAttachment.fromJson(attachment["imageAttachment"]);
        files.add(imageAttachment);
      } else if (attachment["locAttachment"] != null) {
        LocationAttachment locationAttachment = LocationAttachment.fromJson(attachment["locAttachment"]);
        files.add(locationAttachment);
      } else if (attachment["diskAttachments"] != null) {
        DiskAttachments diskAttachments = DiskAttachments.fromJson(attachment["diskAttachments"]);
        files.add(diskAttachments);
      }
    }
    return ShareItem(
      id: map["id"],
      headUrl: map["headUrl"],
      comments: comments,
      showVisible: map["showVisible"],
      type: map["type"],
      files: files,
      publisher: map["publisher"],
      isPublicAccount: map["isPublicAccount"],
      publisherName: map["publisherName"],
      publishTime: map["publishTime"],
      goods: goods,
      content: map["content"]
    );
  }
}