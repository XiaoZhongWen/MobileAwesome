import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_setting.dart';
import 'package:flutter_cloud_platform/base/utils/generate_user_sig.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimAdvancedMsgListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimSDKListener.dart';
import 'package:tencent_im_sdk_plugin/enum/log_level_enum.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_callback.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message_receipt.dart';
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
    void Function(V2TimUserFullInfo info)? onSelfInfoUpdated,
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
        onSelfInfoUpdated: onSelfInfoUpdated,
        onUserSigExpired: onUserSigExpired
    ));
  }

  void addEventListener({
    void Function(List<V2TimMessageReceipt> receiptList)? onRecvC2CReadReceipt,
    void Function(String msgID)? onRecvMessageRevoked,
    void Function(V2TimMessage msg)? onRecvNewMessage,
    void Function(V2TimMessage message, int progress)? onSendMessageProgress
  }) {
    TencentImSDKPlugin.v2TIMManager
        .getMessageManager()
        .addAdvancedMsgListener(listener: V2TimAdvancedMsgListener(
      onRecvC2CReadReceipt: onRecvC2CReadReceipt,
      onRecvMessageRevoked: onRecvMessageRevoked,
      onRecvNewMessage: onRecvNewMessage,
      onSendMessageProgress: onSendMessageProgress
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

  Future<String?> createTextMessage(String text) async {
    V2TimValueCallback<V2TimMsgCreateInfoResult> createMessage = await TencentImSDKPlugin.v2TIMManager
        .getMessageManager()
        .createTextMessage(text: text);
    String? id = createMessage.data?.id;
    return id;
  }

  void sendMessage(String id, String to) async {
    String receiver = '';
    String groupID = '';
    (to.isGroupId() || to.isMassId())?
        groupID = to:
        receiver = to;
    V2TimValueCallback<V2TimMessage> message = await TencentImSDKPlugin.v2TIMManager
        .getMessageManager()
        .sendMessage(id: id, receiver: receiver, groupID: groupID);
  }

}