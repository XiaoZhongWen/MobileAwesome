// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcs_app_global.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MCSAppGlobal _$MCSAppGlobalFromJson(Map<String, dynamic> json) => MCSAppGlobal(
      json['contacts'] == null
          ? null
          : MCSGlobalContacts.fromJson(
              json['contacts'] as Map<String, dynamic>),
      json['openSensitiveWord'] as bool?,
      json['interceptType'] as int?,
      json['mainPageAdImage'] as String?,
      json['h5Url'] as String?,
      json['commonTextConfig'] as String?,
      json['android'] as bool?,
      json['ios'] as bool?,
    );

Map<String, dynamic> _$MCSAppGlobalToJson(MCSAppGlobal instance) =>
    <String, dynamic>{
      'contacts': instance.contacts,
      'openSensitiveWord': instance.openSensitiveWord,
      'interceptType': instance.interceptType,
      'mainPageAdImage': instance.mainPageAdImage,
      'h5Url': instance.h5Url,
      'commonTextConfig': instance.commonTextConfig,
      'android': instance.android,
      'ios': instance.ios,
    };
