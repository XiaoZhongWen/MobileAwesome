
import 'package:assassin_flutter_module/constants.dart';
import 'package:assassin_flutter_module/widgets/test.dart';
import 'package:assassin_flutter_module/widgets/transparent_page.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:assassin_flutter_module/pages/me/me_page.dart';
import 'package:assassin_flutter_module/pages/share/share_page.dart';

// void main() => runApp(_widgetForRoute(window.defaultRouteName));//独立运行传入默认路由
void main() => runApp(_widgetForRoute(route_name_share_page));//独立运行传入默认路由
// void main() => runApp(_widgetForRoute("transparent_page"));//独立运行传入默认路由

Widget _widgetForRoute(String routeName) {
  switch (routeName) {
    case route_name_me_page:
      return MePage();
    case route_name_share_page:
      return SharePage();
    case "transparent_page":
      return Test();
    default:
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text(""),
          ),
        ),
      );
  }
}