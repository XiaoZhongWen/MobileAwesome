import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_app_config.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_theme_config.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mcs_visual.g.dart';

@JsonSerializable()

class MCSVisual {

  MCSVisual(
      this.productId,
      this.guid,
      this.version,
      this.useable,
      this.appConfig,
      this.themeConfig);

  String? productId;
  String? guid;
  int? version;
  bool? useable;
  MCSAppConfig? appConfig;
  MCSThemeConfig? themeConfig;

  factory MCSVisual.fromJson(Map<String, dynamic> json) => _$MCSVisualFromJson(json);
  Map<String, dynamic> toJson() => _$MCSVisualToJson(this);
}