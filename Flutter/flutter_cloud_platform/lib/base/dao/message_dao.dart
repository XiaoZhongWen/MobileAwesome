import 'dart:convert';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/db/mcs_db_service.dart';
import 'package:flutter_cloud_platform/conversation/models/mcs_message.dart';

class MessageDao {

  static const int limit = 20;

  void saveMessage(MCSMessage message) {
    Map<String, dynamic> map = _toRecord(message);
    MCSDBService.singleton.insert(messageTableName, map);
  }

  void deleteMessage(String msgID) {
    MCSDBService.singleton.delete(
        messageTableName,
        where: 'msgID = ?',
        whereArgs: [msgID]);
  }

  void updateMessage(MCSMessage message) {
    Map<String, dynamic> map = _toRecord(message);
    MCSDBService.singleton.update(
        messageTableName,
        map,
        where: 'msgID = ?',
        whereArgs: [message.msgID]);
  }

  Future<List<MCSMessage>> fetchMessages(String peerID, int offset) async {
    List list = await MCSDBService.singleton.query(
        messageTableName,
        where: 'peerID = ?',
        whereArgs: [peerID],
        orderBy: 'timestamp DESC',
        offset: offset,
        limit: limit);
    if (list.isEmpty) {
      return [];
    } else {
      list = list.reversed.toList();
      List<MCSMessage> messages = list.map((e) {
        Map<String, dynamic> map = _tojson(e);
        return MCSMessage.fromJson(map);
      }).toList();
      return messages;
    }
  }

  Map<String, dynamic> _toRecord(MCSMessage message) {
    Map<String, dynamic> map = Map.from(message.toJson());
    map['type'] = message.type.index;
    map['status'] = message.status.index;
    map['isRead'] = (message.isRead ?? false)? 1: 0;
    map['isPeerRead'] = (message.isPeerRead ?? false)? 1: 0;
    map['body'] = json.encode(map['body']);
    return map;
  }

  Map<String, dynamic> _tojson(Map<String, dynamic> record) {
    Map<String, dynamic> map = Map.from(record);
    int isRead = map['isRead'] ?? 0;
    int isPeerRead = map['isPeerRead'] ?? 0;
    map['body'] = json.decode(record['body']);
    map['isRead'] = isRead == 1? true: false;
    map['isPeerRead'] = isPeerRead == 1? true: false;
    return map;
  }
}