import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_asset_image.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_image.dart';

class MCSListTile extends StatelessWidget {
  MCSListTile({
    Key? key,
    this.iconUrl,
    this.title,
    this.subTitle,
    String? placeholder,
    required this.height
  }) : super(key: key) {
    if (placeholder == null || placeholder.isEmpty) {
      this.placeholder = 'contacts/contacts_header';
    } else {
      this.placeholder = placeholder;
    }
  }

  String? iconUrl;
  String? title;
  String? subTitle;
  String? placeholder;
  double height;

  @override
  Widget build(BuildContext context) {
    double iconSize = height * 4/5;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        (iconUrl != null && iconUrl!.isNotEmpty) ?
            MCSImage.cached(imageUrl: iconUrl!, width: iconSize, height: iconSize,) :
            MCSAssetImage(placeholder!, width: iconSize, height: iconSize,),
        Container(
          child: Column(
            children: [
              Text(title ?? ''),
              Text(subTitle ?? ''),
            ],
          ),
        )
      ],
    );
  }
}
