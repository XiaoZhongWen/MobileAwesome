import 'dart:convert';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/db/mcs_db_service.dart';
import 'package:flutter_cloud_platform/conversation/models/mcs_message.dart';

class MessageDao {

  final int _limit = 20;

  void saveMessage(MCSMessage message) {
    MCSDBService.singleton.insert(messageTableName, message.toJson());
  }

  void deleteMessage(String msgID) {
    MCSDBService.singleton.delete(
        messageTableName,
        where: 'msgID = ?',
        whereArgs: [msgID]);
  }

  void updateMessage(MCSMessage message) {
    MCSDBService.singleton.update(
        messageTableName,
        message.toJson(),
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
        limit: _limit);
    if (list.isEmpty) {
      return [];
    } else {
      list = list.reversed.toList();
      List<MCSMessage> messages = list.map((e) {
        Map<String, dynamic> map = Map.from(e);
        String body = map['body'];
        map['body'] = json.decode(body);
        return MCSMessage.fromJson(map);
      }).toList();
      return messages;
    }
  }
}