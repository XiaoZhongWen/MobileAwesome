// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcs_tab.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MCSTab _$MCSTabFromJson(Map<String, dynamic> json) => MCSTab(
      json['id'] as String?,
      json['name'] as String?,
      json['route'] as String?,
      json['selIcon'] as String?,
      json['unselIcon'] as String?,
      json['category'] as String?,
      json['showMessageNotify'] as int?,
      json['num'] as int?,
    );

Map<String, dynamic> _$MCSTabToJson(MCSTab instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'route': instance.route,
      'selIcon': instance.selIcon,
      'unselIcon': instance.unselIcon,
      'category': instance.category,
      'showMessageNotify': instance.showMessageNotify,
      'num': instance.num,
    };
