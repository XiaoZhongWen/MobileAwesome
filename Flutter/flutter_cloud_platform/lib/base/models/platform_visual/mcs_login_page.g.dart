// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcs_login_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MCSLoginPage _$MCSLoginPageFromJson(Map<String, dynamic> json) => MCSLoginPage(
      json['registerUrl'] as String?,
      json['resetPwdUrl'] as String?,
      json['changePwdUrl'] as String?,
      json['loginUrl'] as String?,
      json['showLastAvatar'] as bool?,
      json['showScanButton'] as bool?,
    );

Map<String, dynamic> _$MCSLoginPageToJson(MCSLoginPage instance) =>
    <String, dynamic>{
      'registerUrl': instance.registerUrl,
      'resetPwdUrl': instance.resetPwdUrl,
      'changePwdUrl': instance.changePwdUrl,
      'loginUrl': instance.loginUrl,
      'showLastAvatar': instance.showLastAvatar,
      'showScanButton': instance.showScanButton,
    };
