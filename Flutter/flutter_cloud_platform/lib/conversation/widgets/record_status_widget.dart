import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/conversation/providers/input_status_provider.dart';
import 'package:provider/provider.dart';

class RecordStatusWidget extends StatelessWidget {
  const RecordStatusWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<InputStatusProvider>(builder: (_, provider, __) {
      return Container(
        child: Column(
          children: [
            Row(
              children: [

              ],
            ),
            Text('')
          ],
        ),
      );
    });
  }
}
