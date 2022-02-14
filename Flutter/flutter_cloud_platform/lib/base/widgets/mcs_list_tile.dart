import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_asset_image.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_image.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_title.dart';

class MCSListTile extends StatelessWidget {
  MCSListTile({
    Key? key,
    this.iconUrl,
    this.title,
    this.subTitle,
    this.onTap,
    this.gap,
    this.titleType,
    this.subtitleType,
    this.trialing,
    this.showIcon = true,
    String? placeholder,
    required this.height
  }) : super(key: key) {
    if (placeholder == null || placeholder.isEmpty) {
      this.placeholder = 'contacts/contacts_header';
    } else {
      this.placeholder = placeholder;
    }
  }

  final String? iconUrl;
  final String? title;
  final String? subTitle;
  final double? gap;
  final double height;
  final MCSTitleType? titleType;
  final MCSTitleType? subtitleType;
  final Widget? trialing;
  final bool? showIcon;
  String? placeholder;
  GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    double iconSize = height * 4/5;

    Widget header = MCSLayout.hGap0;
    if (showIcon ?? true) {
      if (iconUrl != null && iconUrl!.isNotEmpty) {
        header = ClipOval(
            child: MCSImage.cached(
                imageUrl: iconUrl!,
                width: iconSize,
                height: iconSize,
                fit: BoxFit.cover
            )
        );
      } else {
        header = ClipOval(
            child: MCSAssetImage(
                placeholder!,
                width: iconSize,
                height: iconSize,
                fit: BoxFit.cover
            )
        );
      }
    }

    return Container(
      height: height,
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            header,
            (showIcon ?? true)? MCSLayout.hGap10: MCSLayout.hGap0,
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildTitles(),
                )
            ),
            Padding(
              padding: EdgeInsets.only(left: MCSLayout.padding),
              child: trialing,
            )
          ],
        ),
      )
    );
  }

  List<Widget> _buildTitles() {
    List<Widget> list = [];
    list.add(MCSTitle(title ?? '', type: titleType,));
    if (subTitle != null && (subTitle?.isNotEmpty ?? false)) {
      list.add(gap != null? SizedBox(height: gap,): MCSLayout.vGap5);
      list.add(MCSTitle(subTitle!, type: subtitleType));
    }
    return list;
  }
}
