import 'package:assassin_flutter_module/pages/me/models/me_tab.dart';

class MeParams {
  bool isGrid;
  List<MeTab> items;

  MeParams({this.isGrid, this.items});

  factory MeParams.fromJson(Map<String, dynamic> json) {
    bool isGrid = json["isGrid"];
    List list = json["items"];
    List<MeTab> tabs = List();
    for (int i = 0; i < list.length; i++) {
      MeTab tab = MeTab.fromJson(list[i]);
      tabs.add(tab);
    }
    return MeParams(
      isGrid: isGrid,
      items: tabs
    );
  }
}