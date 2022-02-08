// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcs_route_menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MCSRouteMenu _$MCSRouteMenuFromJson(Map<String, dynamic> json) => MCSRouteMenu(
      json['icon'] as String?,
      json['route'] as String?,
      json['name'] as String?,
      json['type'] as String?,
      json['category'] as String?,
      json['hiddenAction'] as bool?,
    );

Map<String, dynamic> _$MCSRouteMenuToJson(MCSRouteMenu instance) =>
    <String, dynamic>{
      'icon': instance.icon,
      'route': instance.route,
      'name': instance.name,
      'type': instance.type,
      'category': instance.category,
      'hiddenAction': instance.hiddenAction,
    };
