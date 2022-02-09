import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_title.dart';

class AddContactsPage extends StatefulWidget {
  AddContactsPage({Key? key}) : super(key: key);

  @override
  _AddContactsPageState createState() => _AddContactsPageState();
}

class _AddContactsPageState extends State<AddContactsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MCSTitle('添加好友'),
      ),
    );
  }
}
