import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cloud_platform/contacts/contacts_router.dart';
import 'package:flutter_cloud_platform/conversation/conversation_router.dart';
import 'package:flutter_cloud_platform/routes/not_found_page.dart';
import 'i_router.dart';

class RouterService {
  RouterService._();
  static RouterService shared = RouterService._();
  static FluroRouter _router = FluroRouter();

  List<IRouterProvider> _listRouter = [];

  void initRoutes() {
    _listRouter.clear();

    _router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
          return const NotFoundPage();
    });

    _listRouter.add(ConversationRouter());
    _listRouter.add(ContactsRouter());

    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(_router);
    });
  }
}