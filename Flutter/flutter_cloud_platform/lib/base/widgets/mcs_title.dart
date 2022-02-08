import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_font.dart';

class MCSTitle extends StatelessWidget {

  final String title;

  const MCSTitle(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title,
      style: const TextStyle(
        color: Colors.black,
        overflow: TextOverflow.ellipsis,
        fontSize: titleFontSize,
        fontWeight: titleFontWeight,
      ),
      maxLines: 1,
    );
  }
}
