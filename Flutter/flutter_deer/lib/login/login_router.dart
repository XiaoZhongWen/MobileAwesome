import 'package:fluro/fluro.dart';
import 'package:fluro/src/fluro_router.dart';
import 'package:flutter_deer/login/page/login_page.dart';
import 'package:flutter_deer/routers/i_router.dart';

class LoginRouter implements IRouterProvider {
  static final String loginPage = '/login';

  @override
  void initRouter(FluroRouter router) {
    router.define(loginPage, handler: Handler(handlerFunc: (_, __) => const LoginPage()));
  }
}