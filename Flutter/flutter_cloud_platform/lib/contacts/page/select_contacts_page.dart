import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_title.dart';

class SelectContactsPage extends StatefulWidget {
  SelectContactsPage({Key? key}) : super(key: key);

  @override
  _SelectContactsPageState createState() => _SelectContactsPageState();
}

class _SelectContactsPageState extends State<SelectContactsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MCSTitle('选择联系人'),
      ),
    );
  }
}
