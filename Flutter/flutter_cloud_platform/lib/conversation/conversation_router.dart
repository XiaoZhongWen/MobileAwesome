import 'package:fluro/fluro.dart';
import 'package:fluro/src/fluro_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/routes/i_router.dart';

class ConversationRouter extends IRouterProvider {

  final String _conversationPage = "/conversation";
  final String _searchPage = "/conversation/search";

  @override
  void initRouter(FluroRouter router) {
    router.define(_conversationPage, handler: Handler(handlerFunc: (_, __) => Text('')));
    router.define(_searchPage, handler: Handler(handlerFunc: (_, __) => Text('')));
  }
}