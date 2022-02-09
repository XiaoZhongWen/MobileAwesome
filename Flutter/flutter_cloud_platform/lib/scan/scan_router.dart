import 'package:fluro/fluro.dart';
import 'package:flutter_cloud_platform/routes/i_router.dart';
import 'package:flutter_cloud_platform/scan/page/scan_page.dart';

class ScanRouter extends IRouterProvider {
  static const String scanPage = '/scanPage';

  @override
  void initRouter(FluroRouter router) {
    router.define(scanPage, handler: Handler(handlerFunc: (_, __) => ScanPage()));
  }
}