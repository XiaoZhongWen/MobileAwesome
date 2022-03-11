import 'package:flutter_cloud_platform/base/constant/mcs_message_type.dart';
import 'package:flutter_cloud_platform/conversation/models/mcs_audio_elem.dart';
import 'package:flutter_cloud_platform/conversation/models/mcs_text_elem.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

enum MCSMessageType {
  unknown,
  text,
  time,
  audio
}

enum MCSMessageStatus {
  sending,
  sendFailure,
  sendSuccess,
  receiving,
  receivingFailure,
  receivingSuccess,
  unknown,
}

class MCSMessage {
  MCSMessage(
      this.msgID,
      this.sender,
      this.receiver,
      this.peerID,
      this.timestamp,
      this.type,
      this.status, {
        this.senderName,
        this.receiverName,
        this.isRead,
        this.isPeerRead,
        this.textElem,
        this.audioElem,
      });

  factory MCSMessage.fromJson(Map<String, dynamic> map) {
    String msgID = map['msgID'];
    String sender = map['sender'];
    String receiver = map['receiver'];
    String peerID = map['peerID'];
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
      peerID,
      timestamp,
      MCSMessageType.values[type],
      MCSMessageStatus.values[status],
      senderName: senderName,
      receiverName: receiverName,
      isRead: isRead,
      isPeerRead: isPeerRead,
      textElem: (type == MCSMessageType.text.index && json != null)? MCSTextElem.fromJson(json): null,
      audioElem: (type == MCSMessageType.audio.index && json != null)? MCSAudioElem.fromJson(json): null
    );
  }

  factory MCSMessage.time(double timestamp) {
    return MCSMessage(
        const Uuid().v1(),
        '',
        '',
        '',
        timestamp,
        MCSMessageType.time,
        MCSMessageStatus.unknown);
  }

  Map<String, dynamic> toJson() => {
    'msgID': msgID,
    'sender': sender,
    'receiver': receiver,
    'peerID': peerID,
    'timestamp': timestamp,
    'type': type,
    'status': status,
    'senderName': senderName,
    'receiverName': receiverName,
    'isRead': isRead,
    'isPeerRead': isPeerRead,
    'body': textElem?.toJson() ?? audioElem?.toJson()
  };

  Map<String, dynamic> toBody() {
    return {
      'type': audioText,
      'header': {
        'sender':sender,
        'receiver': receiver,
        'senderName': senderName,
        'receiverName': receiverName,
      },
      'data': textElem?.toJson() ?? audioElem?.toJson()
    };
  }

  final String msgID;
  final String sender;
  final String receiver;
  final String peerID;
  final double timestamp;
  MCSMessageType type;
  MCSMessageStatus status;
  String? senderName;
  String? receiverName;
  bool? isRead;
  bool? isPeerRead;
  MCSTextElem? textElem;
  MCSAudioElem? audioElem;
}

extension ExMCSMessageType on MCSMessageType {
  String get value => [unknown, plainText, timeText, audioText][index];
}

extension ExMCSMessageStatus on MCSMessageStatus {
  int get value => [0, 1, 2, 3, 4, 5, 6][index];
}