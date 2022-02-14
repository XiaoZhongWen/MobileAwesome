import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_font.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_title.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MCSTitle('页面不存在', type: MCSTitleType.barTitle,),
      ),
      body: const Center(
        child: Text('页面不存在',
            style: TextStyle(
                color: Colors.grey,
                fontSize: fontLevel2
            )
        ),
      ),
    );
  }
}
