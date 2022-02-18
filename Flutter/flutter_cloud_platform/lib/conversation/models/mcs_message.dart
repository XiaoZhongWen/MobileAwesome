import 'package:flutter_cloud_platform/base/constant/mcs_message_type.dart';
import 'package:flutter_cloud_platform/conversation/models/mcs_text_elem.dart';

enum MCSMessageType {
  unknown,
  text
}

enum MCSMessageStatus {
  sending,
  sendFailure,
  sendSuccess,
  receiving,
  receivingFailure,
  receivingSuccess
}

class MCSMessage {
  MCSMessage(
      this.msgID,
      this.sender,
      this.receiver,
      this.timestamp,
      this.type,
      this.status, {
        this.senderName,
        this.receiverName,
        this.isRead,
        this.isPeerRead,
        this.textElem
      });

  factory MCSMessage.fromJson(Map<String, dynamic> map) {
    String msgID = map['msgID'];
    String sender = map['sender'];
    String receiver = map['receiver'];
    double timestamp = map['timestamp'];
    int type = map['type'];
    int status = map['status'];
    String? senderName = map['senderName'] as String?;
    String? receiverName = map['receiverName'] as String?;
    bool? isRead = map['isRead'] as bool?;
    bool? isPeerRead = map['isPeerRead'] as bool?;
    Map<String, dynamic>? json = map['body'] as Map<String, dynamic>?;
    return MCSMessage(
      msgID,
      sender,
      receiver,
      timestamp,
      MCSMessageType.values[type],
      MCSMessageStatus.values[status],
      senderName: senderName,
      receiverName: receiverName,
      isRead: isRead,
      isPeerRead: isPeerRead,
      textElem: (type == MCSMessageType.text.index && json != null)? MCSTextElem.fromJson(json): null
    );
  }

  Map<String, dynamic> toJson() => {
    'msgID': msgID,
    'sender': sender,
    'receiver': receiver,
    'timestamp': timestamp,
    'type': type,
    'status': status,
    'senderName': senderName,
    'receiverName': receiverName,
    'isRead': isRead,
    'isPeerRead': isPeerRead,
    'body': textElem?.toJson()
  };

  String msgID;
  String sender;
  String receiver;
  double timestamp;
  MCSMessageType type;
  MCSMessageStatus status;
  String? senderName;
  String? receiverName;
  bool? isRead;
  bool? isPeerRead;
  MCSTextElem? textElem;
}

extension ExMCSMessageType on MCSMessageType {
  String get value => [unknown, plainText][index];
}

extension ExMCSMessageStatus on MCSMessageStatus {
  int get value => [0, 1, 2, 3, 4, 5][index];
}