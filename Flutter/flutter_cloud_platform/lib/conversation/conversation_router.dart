import 'package:fluro/fluro.dart';
import 'package:flutter_cloud_platform/conversation/page/conversation_page.dart';
import 'package:flutter_cloud_platform/conversation/page/search_page.dart';
import 'package:flutter_cloud_platform/routes/i_router.dart';

class ConversationRouter extends IRouterProvider {

  static const String conversationPage = "/conversation";
  static const String searchPage = "/conversation/search";

  @override
  void initRouter(FluroRouter router) {
    router.define(conversationPage, handler: Handler(handlerFunc: (_, __) => ConversationPage()));
    router.define(searchPage, handler: Handler(handlerFunc: (_, __) => SearchPage()));
  }
}