import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_setting.dart';
import 'package:flutter_cloud_platform/base/utils/generate_user_sig.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimSDKListener.dart';
import 'package:tencent_im_sdk_plugin/enum/log_level.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_callback.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_user_full_info.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';

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
        loglevel: inProduction?LogLevel.V2TIM_LOG_NONE:LogLevel.V2TIM_LOG_DEBUG,
        listener: V2TimSDKListener(
        onConnectFailed: onConnectFailed,
        onConnectSuccess: onConnectSuccess,
        onConnecting: onConnecting,
        onKickedOffline: onKickedOffline,
        onSelfInfoUpdated: onSelfInfoUpdated,
        onUserSigExpired: onUserSigExpired
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
}