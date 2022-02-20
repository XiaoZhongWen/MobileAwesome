import 'dart:convert';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_message_type.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_setting.dart';
import 'package:flutter_cloud_platform/base/dao/message_dao.dart';
import 'package:flutter_cloud_platform/base/utils/generate_user_sig.dart';
import 'package:flutter_cloud_platform/conversation/models/mcs_message.dart';
import 'package:flutter_cloud_platform/conversation/models/mcs_text_elem.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimAdvancedMsgListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimSDKListener.dart';
import 'package:tencent_im_sdk_plugin/enum/log_level_enum.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_callback.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_msg_create_info_result.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_user_full_info.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';
import 'package:flutter_cloud_platform/base/extension/extension.dart';

class MCSIMService {
  static final MCSIMService singleton = MCSIMService._();
  MCSIMService._();

  Future<V2TimValueCallback<bool>> initSDK({
    void Function(int code, String error)? onConnectFailed,
    void Function()? onConnectSuccess,
    void Function()? onConnecting,
    void Function()? onKickedOffline,
    void Function()? onSelfInfoUpdated,
    void Function()? onUserSigExpired
  }) {
    return TencentImSDKPlugin.v2TIMManager.initSDK(
        sdkAppID: sdkAppID,
        loglevel: inProduction?LogLevelEnum.V2TIM_LOG_NONE:LogLevelEnum.V2TIM_LOG_DEBUG,
        listener: V2TimSDKListener(
        onConnectFailed: onConnectFailed,
        onConnectSuccess: onConnectSuccess,
        onConnecting: onConnecting,
        onKickedOffline: onKickedOffline,
        onSelfInfoUpdated: (V2TimUserFullInfo info) {
          if (onSelfInfoUpdated != null) {
            onSelfInfoUpdated();
          }
        },
        onUserSigExpired: onUserSigExpired
    ));
  }

  void addEventListener({
    void Function(MCSMessage message)? onRecvNewMessage,
    void Function(String msgID, int progress)? onSendMessageProgress
  }) {
    TencentImSDKPlugin.v2TIMManager
        .getMessageManager()
        .addAdvancedMsgListener(listener: V2TimAdvancedMsgListener(
      onRecvNewMessage: (V2TimMessage msg) {
        if (onRecvNewMessage != null) {
          onRecvNewMessage(convert(msg, false)!);
        }
      },
      onSendMessageProgress: (V2TimMessage message, int progress) {
        if (onSendMessageProgress != null) {
          onSendMessageProgress(message.msgID!, progress);
        }
      }
    ));
  }

  Future<bool> login(String userId, String password) async {
    String userSig = GenerateUserSig(
        sdkAppID,
        key
    ).genSig(
        identifier: userId,
        expire: 7 * 24 * 60 * 1000
    );
    V2TimCallback callback = await TencentImSDKPlugin.v2TIMManager.login(userID: userId, userSig: userSig);
    return callback.code == 0;
  }

  Future<MCSMessage?> sendMessage(String to, String body) async {
    String receiver = '';
    String groupID = '';
    (to.isGroupId() || to.isMassId())?
        groupID = to:
        receiver = to;
    V2TimValueCallback<V2TimMsgCreateInfoResult> customMessage = await TencentImSDKPlugin.v2TIMManager.getMessageManager().createCustomMessage(data: body);
    String? id = customMessage.data?.id;
    if (id != null) {
      V2TimValueCallback<V2TimMessage> message = await TencentImSDKPlugin.v2TIMManager
          .getMessageManager()
          .sendMessage(id: id, receiver: receiver, groupID: groupID);
      return convert(message.data, true);
    }
    return null;
  }

  MCSMessage? convert(V2TimMessage? msg, bool isSelf) {
    if (msg == null) {
      return null;
    }
    String? msgID = msg.msgID;
    double? timestamp = msg.timestamp?.toDouble();
    String data = msg.customElem?.data ?? '';
    if (msg.elemType == 2 && data.isNotEmpty) {
      // 自定义消息
      Map<String, dynamic>? map = json.decode(data) as Map<String, dynamic>?;
      String? msgType = map?['type'] as String?;
      Map<String, dynamic>? msgData = map?['data'] as Map<String, dynamic>?;
      Map<String, dynamic>? header = map?['header'] as Map<String, dynamic>?;
      MCSMessageStatus status = (msg.status == 2)?
        (isSelf? MCSMessageStatus.sendSuccess: MCSMessageStatus.receivingSuccess):
        (isSelf? MCSMessageStatus.sending: MCSMessageStatus.receiving);
      String? sender = header?['sender'];
      String? receiver = header?['receiver'];
      String? senderName = header?['senderName'];
      String? receiverName = header?['receiverName'];
      String? peerID = isSelf? receiver: sender;
      bool isRead = isSelf;
      bool isPeerRead = false;
      MCSMessageType type = MCSMessageType.unknown;
      MCSTextElem? textElem;
      if (msgType == plainText) {
        textElem = (msgData != null)? MCSTextElem.fromJson(msgData): null;
        type = MCSMessageType.text;
      }
      if ((msgID == null || msgID.isEmpty) ||
          (sender == null || sender.isEmpty) ||
          (receiver == null || receiver.isEmpty) ||
          (peerID == null || peerID.isEmpty) ||
          timestamp == null ||
          (textElem == null)) {
        return null;
      }
      MCSMessage message = MCSMessage(
          msgID,
          sender,
          receiver,
          peerID,
          timestamp,
          type,
          status,
          senderName: senderName,
          receiverName: receiverName,
          isRead: isRead,
          isPeerRead: isPeerRead,
          textElem: textElem
      );
      MessageDao dao = MessageDao();
      dao.saveMessage(message);
      return message;
    }
    return null;
  }
}