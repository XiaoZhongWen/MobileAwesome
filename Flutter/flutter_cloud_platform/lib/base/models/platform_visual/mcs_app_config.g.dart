// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcs_app_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MCSAppConfig _$MCSAppConfigFromJson(Map<String, dynamic> json) => MCSAppConfig(
      json['global'] == null
          ? null
          : MCSAppGlobal.fromJson(json['global'] as Map<String, dynamic>),
      json['pages'] == null
          ? null
          : MCSPages.fromJson(json['pages'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MCSAppConfigToJson(MCSAppConfig instance) =>
    <String, dynamic>{
      'global': instance.global,
      'pages': instance.pages,
    };
