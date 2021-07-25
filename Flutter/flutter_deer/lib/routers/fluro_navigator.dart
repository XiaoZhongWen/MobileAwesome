import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_deer/routers/routers.dart';

class NavigatorUtils {
  static void push(BuildContext context,
      String path,
      {bool replace = false,
        bool clearStack = false,
        Object? arguments}) {
    Routers.router.navigateTo(
        context,
        path,
        replace: replace,
        clearStack: clearStack,
        transition: TransitionType.native,
        routeSettings: RouteSettings(
          arguments: arguments
        ));
  }
}