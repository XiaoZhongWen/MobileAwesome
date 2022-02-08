// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mcs_global_contacts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MCSGlobalContacts _$MCSGlobalContactsFromJson(Map<String, dynamic> json) =>
    MCSGlobalContacts(
      json['circleHead'] as bool?,
      json['createGroup'] as bool?,
      json['onlyAdminAtAll'] as bool?,
      json['allowedChangeName'] as bool?,
      json['orgUrl'] as String?,
      json['orgSelectUrl'] as String?,
    );

Map<String, dynamic> _$MCSGlobalContactsToJson(MCSGlobalContacts instance) =>
    <String, dynamic>{
      'circleHead': instance.circleHead,
      'createGroup': instance.createGroup,
      'onlyAdminAtAll': instance.onlyAdminAtAll,
      'allowedChangeName': instance.allowedChangeName,
      'orgUrl': instance.orgUrl,
      'orgSelectUrl': instance.orgSelectUrl,
    };
