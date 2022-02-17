import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/service/mcs_im_service.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message_receipt.dart';

class IMProvider extends ChangeNotifier {
  IMProvider() {
    _init();
  }

  void _init() {
    MCSIMService.singleton.addEventListener(
      onRecvC2CReadReceipt:onRecvC2CReadReceipt,
      onRecvMessageRevoked:onRecvMessageRevoked,
      onRecvNewMessage:onRecvNewMessage,
      onSendMessageProgress:onSendMessageProgress
    );
  }

  void onRecvC2CReadReceipt(List<V2TimMessageReceipt> receiptList) {

  }

  void onRecvMessageRevoked(String msgID) {

  }

  void onRecvNewMessage(V2TimMessage msg) {

  }

  void onSendMessageProgress(V2TimMessage message, int progress) {

  }
}