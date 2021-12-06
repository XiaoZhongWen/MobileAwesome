import 'package:fluro/fluro.dart';
import 'package:fluro/src/fluro_router.dart';
import 'package:flutter/cupertino.dart';

import '../routes/router.dart';

class LoginRouter extends IRouterProvider {

  static String loginPage = "/login";

  @override
  void initRouter(FluroRouter router) {
    router.define(loginPage, handler: Handler(handlerFunc: (_, __) => Text('')));
  }
}