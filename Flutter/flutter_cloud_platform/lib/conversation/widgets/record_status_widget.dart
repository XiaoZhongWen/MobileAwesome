import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_border.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_asset_image.dart';
import 'package:flutter_cloud_platform/conversation/providers/input_status_provider.dart';
import 'package:provider/provider.dart';

class RecordStatusWidget extends StatelessWidget {
  const RecordStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<InputStatusProvider>(builder: (_, provider, __) {
      String volume = provider.volume.toString();
      return Container(
        width: 150.0,
        height: 120.0,
        decoration: BoxDecoration(
          borderRadius: roundBorderRadius,
          color: Colors.black45
        ),
        child: Column(
          children: [
             SizedBox(
              width: 150.0,
              height: 90.0,
              child: provider.status == RecordStatus.canceling?
              Center(
                child: MCSAssetImage('chat/cancel_record', width: 75.0, height: 75.0,),
              ):
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MCSAssetImage('chat/recording', width: 60, height: 90,),
                  MCSAssetImage('chat/volume$volume', width: 60, height: 90,),
                ],
              ),
            ),
            Card(
              color: provider.status == RecordStatus.canceling? Colors.deepOrangeAccent: Colors.transparent,
              shadowColor: Colors.transparent,
              child: const Text(
                '手指上滑, 取消发送',
                style: TextStyle(
                  color: Colors.white
                )),
            ),
          ],
        ),
      );
    });
  }
}
