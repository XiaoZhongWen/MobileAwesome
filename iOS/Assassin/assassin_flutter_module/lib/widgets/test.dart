import 'package:assassin_flutter_module/widgets/transparent_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => TransparentPage()
      },
    );
  }
}
