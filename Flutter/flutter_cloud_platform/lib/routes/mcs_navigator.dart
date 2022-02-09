import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/routes/router.dart';

class MCSNavigator {
  static void push(BuildContext context, String path, {
    bool replace = false,
    bool clearStack = false,
    Object? parameter
  }) {
    RouterService.shared.router.navigateTo(
      context, path,
      replace: replace,
      clearStack: clearStack,
      transition: TransitionType.native,
      routeSettings: RouteSettings(
        arguments: parameter
      )
    );
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}