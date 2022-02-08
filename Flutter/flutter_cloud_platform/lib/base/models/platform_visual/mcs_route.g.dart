// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcs_route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MCSRoute _$MCSRouteFromJson(Map<String, dynamic> json) => MCSRoute(
      json['overflowIcon'] as String?,
      json['content'] as String?,
      (json['menus'] as List<dynamic>?)
          ?.map((e) => MCSRouteMenu.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MCSRouteToJson(MCSRoute instance) => <String, dynamic>{
      'overflowIcon': instance.overflowIcon,
      'content': instance.content,
      'menus': instance.menus,
    };
