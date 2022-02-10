import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_platform.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_setting.dart';
import 'package:flutter_cloud_platform/base/dao/visual_dao.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_route.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_tab.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_visual.dart';
import 'package:flutter_cloud_platform/base/network/platform_api.dart';

class VisualProvider extends ChangeNotifier {

  VisualProvider(this._visual);

  MCSVisual? _visual;

  void set(MCSVisual visual) {
    _visual = visual;
    notifyListeners();
  }

  Map<String, String> tabIconTable() {
    return {
      contactsList1:'tabs/tab_contacts',
      conversation:'tabs/tab_message',
      share1:'tabs/tab_share',
      office1:'tabs/tab_office',
      mine1:'tabs/tab_me',
      web:'tabs/tab_url'
    };
  }

  Map<String, String> selectedTabIconTable() {
    return {
      contactsList1:'tabs/tab_contacts_selected',
      conversation:'tabs/tab_message_selected',
      share1:'tabs/tab_share_selected',
      office1:'tabs/tab_office_selected',
      mine1:'tabs/tab_me_selected',
      web:'tabs/tab_url_selected'
    };
  }

  List<MCSTab?>? tabs() {
    List<MCSTab>? tabs = _visual?.appConfig?.pages?.homePage?.tabs;
    return tabs;
  }

  MCSRoute? fetchRoute(String route) {
    Map<String, MCSRoute>? map = _visual?.appConfig?.pages?.pageConfig;
    return map?[route];
  }

  void fetchPlatformVisual() async {
    VisualDao visualDao = VisualDao();
    MCSVisual? visual = await visualDao.fetchVisualWithId(GUID);
    if (inProduction || visual == null) {
      Response? response = await PlatformApi.singleton.fetchPlatformVisual();
      if (response != null) {
        visual = MCSVisual.fromJson(response.data);
        visualDao.saveVisualData(visual);
      }
    }
    if (visual != null) {
      set(visual);
    }
  }
}