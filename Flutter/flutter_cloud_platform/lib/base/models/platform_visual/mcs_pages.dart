import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_home_page.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_login_page.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_route.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mcs_pages.g.dart';

@JsonSerializable()

class MCSPages {

  MCSPages(this.pageConfig, this.homePage, this.loginPage);

  Map<String, MCSRoute>? pageConfig;
  MCSHomePage? homePage;
  MCSLoginPage? loginPage;

  factory MCSPages.fromJson(Map<String, dynamic> json) => _$MCSPagesFromJson(json);
  Map<String, dynamic> toJson() => _$MCSPagesToJson(this);
}