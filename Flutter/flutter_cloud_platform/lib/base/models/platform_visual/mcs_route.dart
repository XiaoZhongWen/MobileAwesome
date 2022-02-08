import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_route_menu.dart';
import 'package:json_annotation/json_annotation.dart';

part 'mcs_route.g.dart';

@JsonSerializable()

class MCSRoute {

  MCSRoute(this.overflowIcon, this.content, this.menus);

  String? overflowIcon;
  String? content;
  List<MCSRouteMenu>? menus;

  factory MCSRoute.fromJson(Map<String, dynamic> json) => _$MCSRouteFromJson(json);
  Map<String, dynamic> toJson() => _$MCSRouteToJson(this);
}