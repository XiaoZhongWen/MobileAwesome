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
    Map<String, dynamic> filesMap = {};
    if (list.length > 0) {
      String jsonStr = list[0];
      filesMap = json.decode(jsonStr);
    }

    for (String key in filesMap.keys) {
      if (key == "imageAttachment") {
        ImageAttachment imageAttachment = ImageAttachment.fromJson(filesMap[key]);
        files.add(imageAttachment);
      } else if (key == "locAttachment") {
        LocationAttachment locationAttachment = LocationAttachment.fromJson(filesMap[key]);
        files.add(locationAttachment);
      } else if (key == "diskAttachments") {
        DiskAttachments diskAttachments = DiskAttachments.fromJson(filesMap[key]);
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