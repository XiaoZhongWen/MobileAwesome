import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_deer/login/login_router.dart';
import 'package:flutter_deer/routers/i_router.dart';
import 'package:flutter_deer/routers/not_found_page.dart';

class Routers {
  static final List<IRouterProvider> _listRouter = [];
  static final FluroRouter router = FluroRouter();

  static void initRouters() {
    router.notFoundHandler =  Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
      return NotFoundPage();
    });

    _listRouter.add(LoginRouter());

    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}