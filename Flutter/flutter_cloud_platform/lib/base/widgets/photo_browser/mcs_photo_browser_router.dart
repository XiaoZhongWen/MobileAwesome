import 'package:fluro/fluro.dart';
import 'package:fluro/src/fluro_router.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/widgets/photo_browser/mcs_photo_browser.dart';
import 'package:flutter_cloud_platform/routes/i_router.dart';

class MCSPhotoBrowserRouter extends IRouterProvider {

  static const String photoBrowserPage = '/photoBrowser';

  @override
  void initRouter(FluroRouter router) {
    router.define(photoBrowserPage, handler: Handler(handlerFunc: (context, __) {
      final Map<String, dynamic> params = context?.settings?.arguments as Map<String, dynamic>;
      int index = params[photoBrowserIndexKey] as int;
      List<Map<String, String?>> list = params[photoBrowserDataKey] as List<Map<String, String?>>;
      return MCSPhotoBrowser(index: index, datasource: list,);
    }));
  }

}