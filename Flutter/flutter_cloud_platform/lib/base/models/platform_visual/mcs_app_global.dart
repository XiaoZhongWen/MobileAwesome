import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_global_contacts.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mcs_app_global.g.dart';

@JsonSerializable()

class MCSAppGlobal {

  MCSAppGlobal(
      this.contacts,
      this.openSensitiveWord,
      this.interceptType,
      this.mainPageAdImage,
      this.h5Url,
      this.commonTextConfig,
      this.android,
      this.ios);

  MCSGlobalContacts? contacts;
  bool? openSensitiveWord;
  int? interceptType;
  String? mainPageAdImage;
  String? h5Url;
  String? commonTextConfig;
  bool? android;
  bool? ios;

  factory MCSAppGlobal.fromJson(Map<String, dynamic> json) => _$MCSAppGlobalFromJson(json);
  Map<String, dynamic> toJson() => _$MCSAppGlobalToJson(this);
}