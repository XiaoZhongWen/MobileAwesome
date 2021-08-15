import 'package:fluro/fluro.dart';
import 'package:fluro/src/fluro_router.dart';
import 'package:flutter_deer/goods/page/goods_page.dart';
import 'package:flutter_deer/routers/i_router.dart';

class GoodsRouter implements IRouterProvider {
  static String goodsPage = "/goods";

  @override
  void initRouter(FluroRouter router) {
    router.define(goodsPage, handler: Handler(handlerFunc: (_, __) => GoodsPage()));
  }
}