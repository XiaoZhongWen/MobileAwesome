import 'package:flutter/cupertino.dart';

class Screen {
  static Size size(BuildContext context) => MediaQuery.of(context).size;
}

extension MediaQueryExtension on BuildContext {
  double get width => Screen.size(this).width;
}