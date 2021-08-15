import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_deer/goods/goods_router.dart';
import 'package:flutter_deer/home/home.dart';
import 'package:flutter_deer/login/login_router.dart';
import 'package:flutter_deer/order/order_router.dart';
import 'package:flutter_deer/routers/i_router.dart';
import 'package:flutter_deer/routers/not_found_page.dart';
import 'package:flutter_deer/shop/shop_router.dart';
import 'package:flutter_deer/statistics/statistics_router.dart';
import 'package:flutter_deer/store/store_router.dart';

class Routers {

  static String home = "/home";

  static final List<IRouterProvider> _listRouter = [];
  static final FluroRouter router = FluroRouter();

  static void initRouters() {
    router.notFoundHandler =  Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
      return NotFoundPage();
    });
    
    router.define(home, handler: Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) => Home()));

    _listRouter.add(LoginRouter());
    _listRouter.add(StoreRouter());
    _listRouter.add(ShopRouter());
    _listRouter.add(OrderRouter());
    _listRouter.add(GoodsRouter());
    _listRouter.add(StatisticsRouter());

    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}