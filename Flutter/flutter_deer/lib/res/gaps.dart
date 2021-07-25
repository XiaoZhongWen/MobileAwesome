import 'package:flutter/cupertino.dart';
import 'package:flutter_deer/res/Dimens.dart';

class Gaps {
  /// 产生的空组件没有背景、没有装饰、大小为0，并且不影响父组件的约束
  static const Widget empty = SizedBox.shrink();

  static const Widget vGap8 = SizedBox(height: Dimens.gap_dp8);
  static const Widget vGap16 = SizedBox(height: Dimens.gap_dp16);
  static const Widget vGap24 = SizedBox(height: Dimens.gap_dp24);
  static const Widget vGap50 = SizedBox(height: Dimens.gap_dp50);
}