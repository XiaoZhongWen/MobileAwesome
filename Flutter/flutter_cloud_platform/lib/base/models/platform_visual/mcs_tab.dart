import 'package:json_annotation/json_annotation.dart';

part 'mcs_tab.g.dart';

@JsonSerializable()

class MCSTab {

  MCSTab(this.id,
      this.name,
      this.route,
      this.selIcon,
      this.unselIcon,
      this.category,
      this.showMessageNotify,
      this.num);

  String? id;
  String? name;
  String? route;
  String? selIcon;
  String? unselIcon;
  String? category;
  int? showMessageNotify;
  int? num;

  factory MCSTab.fromJson(Map<String, dynamic> json) => _$MCSTabFromJson(json);
  Map<String, dynamic> toJson() => _$MCSTabToJson(this);
}