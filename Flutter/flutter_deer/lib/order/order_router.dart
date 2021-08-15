import 'package:fluro/fluro.dart';
import 'package:fluro/src/fluro_router.dart';
import 'package:flutter_deer/order/page/order_page.dart';
import 'package:flutter_deer/routers/i_router.dart';

class OrderRouter implements IRouterProvider {

  static String orderPage = "/order";

  @override
  void initRouter(FluroRouter router) {
    router.define(orderPage, handler: Handler(handlerFunc: (_, __) => OrderPage()));
  }

}