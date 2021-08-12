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

  static void goBack(BuildContext context) {
    unfocus();
    Navigator.pop(context);
  }

  static void unfocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static void pushResult(BuildContext context,
      String path,
      Function(Object) function,
      {bool replace = false, bool clearStack = false, Object? arguments}) {
    unfocus();
    Routers.router.navigateTo(
        context,
        path,
        replace: replace,
        clearStack: clearStack,
        transition: TransitionType.native,
        routeSettings: RouteSettings(
            arguments: arguments
        )).then((Object? result) {
          if (result == null) {
            return;
          }
          function(result);
    }).catchError(((Object error) {
      print('$error');
    }));
  }
}