import 'package:fluro/fluro.dart';
import 'package:fluro/src/fluro_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/routers/i_router.dart';
import 'package:flutter_deer/shop/page/select_address_page.dart';

class ShopRouter implements IRouterProvider {

  static String addressSelectPage = "/shop/addressSelect";

  @override
  void initRouter(FluroRouter router) {
    router.define(addressSelectPage, handler: Handler(handlerFunc: (_,__) => SelectAddressPage()));
  }

}