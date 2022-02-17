import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/utils/mcs_view_port.dart';

extension ExBuildContext on BuildContext {
  Size get size => MCSViewPort.size(this);
  double get width => MCSViewPort.size(this).width;
  double get height => MCSViewPort.size(this).height;
}