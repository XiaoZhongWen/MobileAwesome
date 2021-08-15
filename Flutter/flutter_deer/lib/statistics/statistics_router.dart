import 'package:fluro/fluro.dart';
import 'package:fluro/src/fluro_router.dart';
import 'package:flutter_deer/routers/i_router.dart';
import 'package:flutter_deer/statistics/page/statistics_page.dart';

class StatisticsRouter implements IRouterProvider {
  static String statistics = "/statistics";

  @override
  void initRouter(FluroRouter router) {
    router.define(statistics, handler: Handler(handlerFunc: (_, __) => StatisticsPage()));
  }
}