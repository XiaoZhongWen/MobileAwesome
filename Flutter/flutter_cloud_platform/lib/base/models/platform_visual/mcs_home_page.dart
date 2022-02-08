import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_tab.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mcs_home_page.g.dart';

@JsonSerializable()

class MCSHomePage {

  MCSHomePage(this.h5Url, this.tabs);

  String? h5Url;
  List<MCSTab>? tabs;

  factory MCSHomePage.fromJson(Map<String, dynamic> json) => _$MCSHomePageFromJson(json);
  Map<String, dynamic> toJson() => _$MCSHomePageToJson(this);
}