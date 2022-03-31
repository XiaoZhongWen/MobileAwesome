import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cloud_platform/base/widgets/photo_browser/mcs_photo_browser_router.dart';
import 'package:flutter_cloud_platform/contacts/contacts_router.dart';
import 'package:flutter_cloud_platform/conversation/conversation_router.dart';
import 'package:flutter_cloud_platform/routes/not_found_page.dart';
import 'package:flutter_cloud_platform/scan/scan_router.dart';
import 'i_router.dart';

class RouterService {
  RouterService._();
  static RouterService shared = RouterService._();
  final FluroRouter router = FluroRouter();

  List<IRouterProvider> _listRouter = [];

  void initRoutes() {
    _listRouter.clear();

    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> parameters) {
          return const NotFoundPage();
    });

    _listRouter.add(ConversationRouter());
    _listRouter.add(ContactsRouter());
    _listRouter.add(ScanRouter());
    _listRouter.add(MCSPhotoBrowserRouter());

    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}