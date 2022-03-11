import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_asset_image.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: FractionallySizedBox(
          widthFactor: 0.33,
          heightFactor: 0.3,
          child: MCSAssetImage('logo')
        ),
      ),
    );
  }
}
