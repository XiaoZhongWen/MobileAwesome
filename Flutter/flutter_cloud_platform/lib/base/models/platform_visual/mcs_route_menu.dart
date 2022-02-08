import 'package:json_annotation/json_annotation.dart';

part 'mcs_route_menu.g.dart';

@JsonSerializable()

class MCSRouteMenu {

  MCSRouteMenu(this.icon,
      this.route,
      this.name,
      this.type,
      this.category,
      this.hiddenAction);

  String? icon;
  String? route;
  String? name;
  String? type;
  String? category;
  bool? hiddenAction;

  factory MCSRouteMenu.fromJson(Map<String, dynamic> json) => _$MCSRouteMenuFromJson(json);
  Map<String, dynamic> toJson() => _$MCSRouteMenuToJson(this);
}