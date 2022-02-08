import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_platform.dart';
import 'package:flutter_cloud_platform/base/dao/visual_dao.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_visual.dart';
import 'package:flutter_cloud_platform/base/network/platform_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('#test platfrom api', () async {
    // Response response = await PlatformApi.singleton.fetchPlatformVisualData();
    // MCSVisual visual = MCSVisual.fromJson(response.data);
    // VisualDao visualDao = VisualDao();
    // visualDao.saveVisualData(visual);
    //
    // MCSVisual? localVisual = await visualDao.fetchVisualWithId(GUID);
    // print(localVisual);
    //
    // expect(response.data['method'], 'POST');
  });
}