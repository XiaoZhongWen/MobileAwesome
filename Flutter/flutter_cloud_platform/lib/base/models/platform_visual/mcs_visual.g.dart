// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcs_visual.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MCSVisual _$MCSVisualFromJson(Map<String, dynamic> json) => MCSVisual(
      json['productId'] as String?,
      json['guid'] as String?,
      json['version'] as int?,
      json['useable'] as bool?,
      json['appConfig'] == null
          ? null
          : MCSAppConfig.fromJson(json['appConfig'] as Map<String, dynamic>),
      json['themeConfig'] == null
          ? null
          : MCSThemeConfig.fromJson(
              json['themeConfig'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MCSVisualToJson(MCSVisual instance) => <String, dynamic>{
      'productId': instance.productId,
      'guid': instance.guid,
      'version': instance.version,
      'useable': instance.useable,
      'appConfig': instance.appConfig,
      'themeConfig': instance.themeConfig,
    };
