// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcs_home_page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MCSHomePage _$MCSHomePageFromJson(Map<String, dynamic> json) => MCSHomePage(
      json['h5Url'] as String?,
      (json['tabs'] as List<dynamic>?)
          ?.map((e) => MCSTab.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MCSHomePageToJson(MCSHomePage instance) =>
    <String, dynamic>{
      'h5Url': instance.h5Url,
      'tabs': instance.tabs,
    };
