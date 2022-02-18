import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/cache/mcs_memory_cache.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_message_type.dart';
import 'package:flutter_cloud_platform/base/service/mcs_im_service.dart';
import 'package:flutter_cloud_platform/conversation/models/mcs_message.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message_receipt.dart';

class IMProvider extends ChangeNotifier {
  IMProvider() {
    _init();
  }

  /*
  * 当前会话中对方的账号
  * */
  String? peerID;

  Map<String, Map<String, dynamic>> _datasource = {};

  void _init() {
    MCSIMService.singleton.addEventListener(
      onRecvNewMessage:onRecvNewMessage,
      onSendMessageProgress:onSendMessageProgress
    );
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
    switch (type) {
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
    MCSIMService.singleton.sendMessage(receiver, json.encode(map));
  }

  void onRecvC2CReadReceipt(List<V2TimMessageReceipt> receiptList) {

  }

  void onRecvMessageRevoked(String msgID) {

  }

  void onRecvNewMessage(MCSMessage msg) {

  }

  void onSendMessageProgress(String msgID, int progress) {

  }
}