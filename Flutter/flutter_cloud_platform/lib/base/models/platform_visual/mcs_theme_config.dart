import 'package:json_annotation/json_annotation.dart';

part 'mcs_theme_config.g.dart';

@JsonSerializable()

class MCSThemeConfig {

  MCSThemeConfig(this.patch,
      this.themeUrl,
      this.md5,
      this.themeVersion);

  bool? patch;
  String? themeUrl;
  String? md5;
  int? themeVersion;

  factory MCSThemeConfig.fromJson(Map<String, dynamic> json) => _$MCSThemeConfigFromJson(json);
  Map<String, dynamic> toJson() => _$MCSThemeConfigToJson(this);
}