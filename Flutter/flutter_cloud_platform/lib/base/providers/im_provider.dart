import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/cache/mcs_memory_cache.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_message_type.dart';
import 'package:flutter_cloud_platform/base/dao/message_dao.dart';
import 'package:flutter_cloud_platform/base/service/mcs_im_service.dart';
import 'package:flutter_cloud_platform/conversation/models/mcs_message.dart';

class IMProvider extends ChangeNotifier {
  IMProvider() {
    _init();
  }

  /*
  * 当前会话中对方的账号
  * */
  String? peerID;

  final Map<String, Map<String, MCSMessage>> _datasource = {};

  void _init() {
    MCSIMService.singleton.addEventListener(
      onRecvNewMessage:onRecvNewMessage,
      onSendMessageProgress:onSendMessageProgress
    );
  }

  List<MCSMessage> fetchMessageList({int? offset, bool? async = false}) {
    List<MCSMessage> list = [];
    if (peerID == null || peerID!.isEmpty) {
      return list;
    }
    List<MCSMessage> cache = _datasource[peerID]?.values.toList() ?? [];
    if (async ?? false) {
      MessageDao dao = MessageDao();
      dao.fetchMessages(peerID!, offset ?? 0).then((messages) => addMessages(messages));
    } else {
      cache.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      list.addAll(addTime(cache));
    }
    return list;
  }

  List<MCSMessage> addTime(List<MCSMessage> list) {
    List<MCSMessage> messages = [];
    double timestamp = 0.0;
    for (MCSMessage msg in list) {
      if (timestamp == 0.0) {
        // 第一条消息前插入时间消息
        messages.add(MCSMessage.time(msg.timestamp));
      } else if (msg.timestamp - timestamp > 60.0) {
        // 超过一分钟插入时间消息
        messages.add(MCSMessage.time(msg.timestamp));
      }
      messages.add(msg);
      timestamp = msg.timestamp;
    }
    return messages;
  }

  void addMessages(List<MCSMessage> messages) {
    if (peerID == null || peerID!.isEmpty) {
      return;
    }
    Map<String, MCSMessage> map = {};
    if (_datasource[peerID] == null) {
      _datasource[peerID!] = map;
    } else {
      map = _datasource[peerID!]!;
    }
    List<String> keys = map.keys.toList();
    for (var msg in messages) {
      if (!keys.contains(msg.msgID)) {
        map[msg.msgID] = msg;
      }
    }
    notifyListeners();
  }

  /*
  * 发送消息
  * receiver: 接收方id
  * type: 消息类型
  * text: text/plain 消息内容
  * */
  void sendMessage(
      String receiver,
      MCSMessageType type, {
        String? receiverName,
        String? text
      }) {
    switch(type) {
      case MCSMessageType.text: {
        if (text != null) {
          _sendTextMessage(receiver, text, receiverName: receiverName);
        }
        break;
      }
    }
  }

  /*
  * 发送文本消息
  * receiver: 接收方id
  * type: 消息类型
  * */
  void _sendTextMessage(String receiver, String text, {String? receiverName}) async {
    String? sender = MCSMemoryCache.singleton.fetchAccountId();
    String? senderName = MCSMemoryCache.singleton.fetchAccountDisplayName();
    Map<String, dynamic> map = {
      'type': plainText,
      'header': {
        'sender':sender,
        'receiver':receiver,
        'senderName':senderName,
        'receiverName':receiverName,
      },
      'data': {
        'text':text
      }
    };
    MCSMessage? message = await MCSIMService.singleton.sendMessage(receiver, json.encode(map));
    if (message != null) {
      addMessages([message]);
    }
  }

  void onRecvNewMessage(MCSMessage msg) {
    addMessages([msg]);
  }

  void onSendMessageProgress(String msgID, int progress) {

  }
}