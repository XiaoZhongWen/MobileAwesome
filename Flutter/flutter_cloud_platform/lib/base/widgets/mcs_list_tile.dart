import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_asset_image.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_image.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_list_subtitle.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_list_title.dart';

class MCSListTile extends StatelessWidget {
  MCSListTile({
    Key? key,
    this.iconUrl,
    this.title,
    this.subTitle,
    this.onTap,
    this.gap,
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
  String? placeholder;
  GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    double iconSize = height * 4/5;
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: MCSLayout.padding),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (iconUrl != null && iconUrl!.isNotEmpty) ?
            ClipOval(
                child: MCSImage.cached(
                    imageUrl: iconUrl!,
                    width: iconSize,
                    height: iconSize,
                    fit: BoxFit.cover
                )
            ) :
            ClipOval(
              child: MCSAssetImage(
                  placeholder!,
                  width: iconSize,
                  height: iconSize,
                  fit: BoxFit.cover
              ),
            ),
            MCSLayout.hGap10,
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildTitles(),
                )
            ),
          ],
        ),
      )
    );
  }

  List<Widget> _buildTitles() {
    List<Widget> list = [];
    list.add(MCSListTitle(title ?? ''));
    if (subTitle != null && (subTitle?.isNotEmpty ?? false)) {
      list.add(gap != null? SizedBox(height: gap,): MCSLayout.vGap5);
      list.add(MCSListSubtitle(subTitle!));
    }
    return list;
  }
}
