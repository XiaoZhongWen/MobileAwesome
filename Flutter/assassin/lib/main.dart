import 'package:flutter/material.dart';
import 'routes/router.dart';
import 'login/page/login_page_test_1.dart';

void main() => runApp(Assassin());

class Assassin extends StatelessWidget {

  Assassin({Key? key}):super(key: key) {
    // 初始化app路由
    RouterService.shared.initRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

