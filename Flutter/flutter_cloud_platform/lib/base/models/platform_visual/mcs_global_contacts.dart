import 'package:json_annotation/json_annotation.dart';

part 'mcs_global_contacts.g.dart';

@JsonSerializable()

class MCSGlobalContacts {
  MCSGlobalContacts(
      this.circleHead,
      this.createGroup,
      this.onlyAdminAtAll,
      this.allowedChangeName,
      this.orgUrl,
      this.orgSelectUrl);

  bool? circleHead;
  bool? createGroup;
  bool? onlyAdminAtAll;
  bool? allowedChangeName;
  String? orgUrl;
  String? orgSelectUrl;

  factory MCSGlobalContacts.fromJson(Map<String, dynamic> json) => _$MCSGlobalContactsFromJson(json);
  Map<String, dynamic> toJson() => _$MCSGlobalContactsToJson(this);
}