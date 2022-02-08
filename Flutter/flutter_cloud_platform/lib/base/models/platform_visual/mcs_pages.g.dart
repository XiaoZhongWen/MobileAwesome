// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcs_pages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MCSPages _$MCSPagesFromJson(Map<String, dynamic> json) => MCSPages(
      (json['pageConfig'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, MCSRoute.fromJson(e as Map<String, dynamic>)),
      ),
      json['homePage'] == null
          ? null
          : MCSHomePage.fromJson(json['homePage'] as Map<String, dynamic>),
      json['loginPage'] == null
          ? null
          : MCSLoginPage.fromJson(json['loginPage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MCSPagesToJson(MCSPages instance) => <String, dynamic>{
      'pageConfig': instance.pageConfig,
      'homePage': instance.homePage,
      'loginPage': instance.loginPage,
    };
