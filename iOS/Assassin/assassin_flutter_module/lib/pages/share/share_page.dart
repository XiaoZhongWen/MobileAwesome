import 'package:assassin_flutter_module/pages/share/routes/home_page.dart';
import 'package:flutter/material.dart';
import 'package:assassin_flutter_plugin/assassin_flutter_plugin.dart';

class SharePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => HomePage()
      },
    );
  }
}

