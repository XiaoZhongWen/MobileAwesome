import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'mcs_constant.dart';

const bool inProduction  = kReleaseMode;
const Brightness themeMode = Brightness.light;
Color primaryColor = themeMode == Brightness.light? MCSColors.mainColor: MCSColors.darkMainColor;
const Duration splashDuration = Duration(seconds: 2);
