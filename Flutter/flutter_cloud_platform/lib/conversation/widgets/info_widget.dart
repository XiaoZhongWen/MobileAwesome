import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_title.dart';

class InfoWidget extends StatelessWidget {
  InfoWidget(this.info, {Key? key}) : super(key: key);

  final String info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MCSLayout.padding, vertical: MCSLayout.vPadding),
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: const BoxDecoration(
          color: MCSColors.lightGrey,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: MCSTitle(info, type: MCSTitleType.listInfoTitle,),
      )
    );
  }
}
