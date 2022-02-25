import 'package:flutter/material.dart';

class MCSViewPort {
  // Querying the current media using MediaQuery.of will cause your widget to rebuild automatically whenever the MediaQueryData changes
  static Size size(BuildContext context) => MediaQuery.of(context).size;
}