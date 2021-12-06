import 'package:fluro/fluro.dart';
import 'i_router.dart';

class RouterService {
  RouterService._();
  static RouterService shared = RouterService._();
  static FluroRouter _router = FluroRouter();

  List<IRouterProvider> _listRouter = [];

  void initRoutes() {
    _listRouter.clear();
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(_router);
    });
  }
}