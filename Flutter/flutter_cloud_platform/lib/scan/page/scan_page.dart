import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_title.dart';

class ScanPage extends StatefulWidget {
  ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MCSTitle('扫一扫', type: MCSTitleType.barTitle,),
      ),
    );
  }
}
