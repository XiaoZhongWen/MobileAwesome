import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_font.dart';

class MCSListSubtitle extends StatelessWidget {
  const MCSListSubtitle(String this.title, {Key? key}) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Text(
        title ?? '',
        style: const TextStyle(
            color: MCSColors.subtitleColor,
            fontSize: fontLevel3
        )
    );
  }
}
