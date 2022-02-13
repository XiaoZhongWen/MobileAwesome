import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_font.dart';

class MCSListTitle extends StatelessWidget {
  const MCSListTitle(String this.title, {Key? key}) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? '',
      style: const TextStyle(color: Colors.black, fontSize: fontLevel5)
    );
  }
}
