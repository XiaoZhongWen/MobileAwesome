import 'dart:convert';
import 'package:assassin_flutter_module/channels/application_configuration_channel.dart';
import 'package:assassin_flutter_module/constants.dart';
import 'package:assassin_flutter_module/pages/share/models/share_item.dart';
import 'package:assassin_flutter_module/pages/share/services/share_service.dart';
import 'package:assassin_flutter_module/pages/share/widgets/share_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _themeColor = Colors.blue;
  List<ShareItem> _shareList;

  @override
  void initState() {
    // TODO: implement initState
    ApplicationConfigurationChannel.shared.fetchThemeColor().then((color) {
      setState(() {
        _themeColor = color;
      });
    });

    ShareService.shared.fetchShares(0)
        .then((shares) {
          setState(() {
            _shareList = shares;
          });
    })
        .catchError((e) {
          print(e);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("分享"),
        backgroundColor: _themeColor,
      ),
      body: Container(
        child: ListView.separated(
            itemBuilder: (context, index) {
              ShareItem item = _shareList[index];
              return ShareCell(shareItem: item,);
            },
            separatorBuilder: (context, index) {
              return Divider(height: divide_height, indent: divide_indent,);
            },
            itemCount: _shareList?.length ?? 0),
      ),
    );
  }
}
