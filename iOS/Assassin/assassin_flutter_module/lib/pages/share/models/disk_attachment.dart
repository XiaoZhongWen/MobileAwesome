import 'dart:convert';

class DiskAttachment {
  String fileName;
  int fileSize;
  String url;

  DiskAttachment({this.fileName, this.fileSize, this.url});

  factory DiskAttachment.fromJson(Map<String, dynamic> json) {
    return DiskAttachment(
      fileName: json["fileName"],
      fileSize: json["fileSize"],
      url: json["url"],
    );
  }
}

class DiskAttachments {
  List<DiskAttachment> diskAttachments;

  DiskAttachments({this.diskAttachments});

  factory DiskAttachments.fromJson(List list) {
    List<DiskAttachment> attachments = List();
    for(int i = 0; i < list?.length ?? 0; i++) {
      DiskAttachment attachment = DiskAttachment.fromJson(list[i]);
      attachments.add(attachment);
    }
    return DiskAttachments(diskAttachments: attachments);
  }
}