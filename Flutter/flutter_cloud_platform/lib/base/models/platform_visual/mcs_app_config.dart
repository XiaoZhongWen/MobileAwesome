import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_app_global.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_pages.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mcs_app_config.g.dart';

@JsonSerializable()

class MCSAppConfig {

  MCSAppConfig(this.global, this.pages);

  MCSAppGlobal? global;
  MCSPages? pages;

  factory MCSAppConfig.fromJson(Map<String, dynamic> json) => _$MCSAppConfigFromJson(json);
  Map<String, dynamic> toJson() => _$MCSAppConfigToJson(this);
}