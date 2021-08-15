import 'package:flutter/cupertino.dart';
import 'package:flutter_deer/res/Dimens.dart';

class Gaps {
  /// 产生的空组件没有背景、没有装饰、大小为0，并且不影响父组件的约束
  static const Widget empty = SizedBox.shrink();

  static const Widget vGap5 = SizedBox(height: Dimens.gap_dp5);
  static const Widget vGap8 = SizedBox(height: Dimens.gap_dp8);
  static const Widget vGap10 = SizedBox(height: Dimens.gap_dp10);
  static const Widget vGap12 = SizedBox(height: Dimens.gap_dp12);
  static const Widget vGap16 = SizedBox(height: Dimens.gap_dp16);
  static const Widget vGap24 = SizedBox(height: Dimens.gap_dp24);
  static const Widget vGap32 = SizedBox(height: Dimens.gap_dp32);
  static const Widget vGap50 = SizedBox(height: Dimens.gap_dp50);

  static const Widget hGap8 = SizedBox(width: Dimens.gap_dp8);
  static const Widget hGap15 = SizedBox(width: Dimens.gap_dp15);
  static const Widget hGap16 = SizedBox(width: Dimens.gap_dp16);
}