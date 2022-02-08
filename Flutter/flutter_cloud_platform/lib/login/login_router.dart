import 'package:fluro/fluro.dart';
import 'package:fluro/src/fluro_router.dart';
import 'package:flutter/cupertino.dart';

import '../routes/router.dart';

class LoginRouter extends IRouterProvider {

  final String _loginPage = "/login";

  @override
  void initRouter(FluroRouter router) {
    router.define(_loginPage, handler: Handler(handlerFunc: (_, __) => Text('')));
  }
}