import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_list_tile.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_title.dart';
import 'package:flutter_cloud_platform/contacts/providers/contacts_detail_provider.dart';
import 'package:provider/provider.dart';

class ContactsDetailPage extends StatefulWidget {
  ContactsDetailPage({Key? key, this.userId}) : super(key: key);

  String? userId;

  @override
  _ContactsDetailPageState createState() => _ContactsDetailPageState();
}

class _ContactsDetailPageState extends State<ContactsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MCSTitle('详细资料'),
      ),
      body: ChangeNotifierProvider.value(
        value: ContactsDetailProvider(widget.userId),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHeader(),
            _buildFooter()
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Card(
          margin: EdgeInsets.all(MCSLayout.margin),
          elevation: 5,
          child: MCSListTile(
            iconUrl: 'https://wx2.sinaimg.cn/mw2000/b4505429ly8gcwoi6xlvcj20e80e8glx.jpg',
            title: 'Sally',
            subTitle: '18627978683',
            height: 100.0,
            gap: MCSLayout.padding,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MCSLayout.margin),
          child: ListTile(title: MCSTitle('个人空间', type: MCSTitleType.small), trailing: Icon(Icons.arrow_forward_ios, size: 12,), contentPadding: EdgeInsets.zero,)
        )
      ],
    );
  }

  Widget _buildFooter() {
    return Container(
      height: 200,
      color: Colors.yellow,
    );
  }
}
