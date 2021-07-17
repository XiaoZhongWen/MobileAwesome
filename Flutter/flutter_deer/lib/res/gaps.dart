import 'package:flutter/cupertino.dart';

class Gaps {
  /// 产生的空组件没有背景、没有装饰、大小为0，并且不影响父组件的约束
  static const Widget empty = SizedBox.shrink();
}