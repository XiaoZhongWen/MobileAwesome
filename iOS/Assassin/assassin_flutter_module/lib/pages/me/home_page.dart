
import 'package:flutter/material.dart';
import 'package:assassin_flutter_module/constants.dart';
import 'package:assassin_flutter_module/pages/me/models/account.dart';
import 'package:assassin_flutter_module/pages/me/models/me_params.dart';
import 'package:assassin_flutter_module/pages/me/models/me_tab.dart';
import 'package:assassin_flutter_module/pages/me/setting/setting_page.dart';
import 'package:assassin_flutter_module/pages/me/widgets/me_tab_icon.dart';
import 'package:assassin_flutter_module/channels/application_configuration_channel.dart';
import 'package:assassin_flutter_module/pages/me/widgets/business_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _themeColor = Colors.blue;
  MeParams _params;
  @override
  void initState() {
    // TODO: implement initState
    ApplicationConfigurationChannel.shared.fetchTabs().then((params) {
      _params = params;
    });
    ApplicationConfigurationChannel.shared.fetchThemeColor().then((color) {
      setState(() {
        _themeColor = color;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("我"),
          backgroundColor: _themeColor,
        ),
        body: Container(
          child: Column(
            children: [
              BusinessCard(),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: default_margin, right: default_margin),
                child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.2
                    ),
                    itemCount: _params?.items?.length ?? 0,
                    itemBuilder: (context, index) {
                      MeTab tab = _params.items[index];
                      return MeTabIcon(tab, _onTabClick);
                    }),
              ),
            ],
          ),
        )
    );
  }

  void _onTabClick(int type) {
    if (type == 7) {
      // 设置
      Navigator.pushNamed(this.context, route_name_setting);
    }
  }
}
