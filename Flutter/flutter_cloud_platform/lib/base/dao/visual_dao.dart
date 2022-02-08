import 'dart:convert';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_visual.dart';
import '../db/mcs_db_service.dart';
import '../../base/extension/extension.dart';

class VisualDao {

  void saveVisualData(MCSVisual visual) async {
    String guid = visual.guid ?? '';
    if (guid.isEmpty) {
      return;
    }
    MCSVisual? localVisual = await fetchVisualWithId(guid);
    int oldVersion = localVisual?.version ?? -1;
    Map<String, dynamic> map = visual.toJson();
    String visualText = jsonEncode(map);
    Map<String, Object?> json = {
      'version':map['version'],
      'useable':map['useable'],
      'productId':map['productId'],
      'guid':map['guid'],
      'mcs_visual':visualText
    };
    if (localVisual == null) {
      MCSDBService.singleton.insert(visualTableName, json);
    } else if (oldVersion != visual.version) {
      MCSDBService.singleton.update(visualTableName, json, where: 'guid = ?', whereArgs: [visual.guid]);
    }
  }

  Future<MCSVisual?> fetchVisualWithId(String guid) async {
    List list = await MCSDBService.singleton.query(visualTableName, where: 'guid = ?', whereArgs: [guid]);
    if (list.isEmpty) {
      return Future.value(null);
    } else {
      Map<String, Object?> record = list.first;
      String str = record['mcs_visual'] as String? ?? '';
      Map<String, Object?> map = json.decode(str);
      MCSVisual visual = MCSVisual.fromJson(map);
      return visual;
    }
  }
}