import 'package:assassin_flutter_module/constants.dart';
import 'package:assassin_flutter_module/pages/me/home_page.dart';
import 'package:assassin_flutter_module/pages/me/setting/new_msg_tip_page.dart';
import 'package:assassin_flutter_module/pages/me/setting/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage(),
        route_name_setting: (context) => SettingPage(),
        route_name_new_msg_tip: (context) => NewMsgTipPage()
      },
    );
  }
}