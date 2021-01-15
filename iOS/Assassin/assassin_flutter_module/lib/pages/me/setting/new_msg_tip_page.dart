import 'package:assassin_flutter_module/channels/application_configuration_channel.dart';
import 'package:assassin_flutter_module/constants.dart';
import 'package:assassin_flutter_module/pages/me/models/setting_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NewMsgTipPage extends StatefulWidget {
  @override
  _NewMsgTipPageState createState() => _NewMsgTipPageState();
}

class _NewMsgTipPageState extends State<NewMsgTipPage> {
  List<SettingItem> _list;

  @override
  void initState() {
    List<SettingItem> list = _initialData();
    setState(() {
      _list = list;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color themeColor = ApplicationConfigurationChannel.shared.fetchThemeColorSync();
    return Scaffold(
      appBar: AppBar(
        title: Text("新消息提醒"),
        backgroundColor: themeColor,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            SettingItem item = _list[index];
            if (item.type == SettingItemType.settingItemTypeSwitchAction) {
              return ListTile(
                title: Text(item.title ?? "", style: TextStyle(fontSize: font_size_level_3)),
                trailing: Switch.adaptive(
                  activeColor: themeColor,
                  value: item.isOn,
                  onChanged: (isOn) {
                    setState(() {
                      item.isOn = isOn;
                    });
                  },
                ),
              );
            } else {
              return Container();
            }
          },
          separatorBuilder: (context, index) {
            return Divider(height: divide_height, indent: divide_indent,);
          },
          itemCount: _list?.length ?? 0
      ),
    );
  }

  List<SettingItem> _initialData() {
    List<SettingItem> list = List();

    SettingItem acceptNotify = SettingItem(title: "接收新消息通知", type: SettingItemType.settingItemTypeSwitchAction, isOn: true, callback: switchNewMsgNotify);
    SettingItem ring = SettingItem(title: "声音", type: SettingItemType.settingItemTypeSwitchAction, isOn: true, callback: switchRing);
    SettingItem shake = SettingItem(title: "震动", type: SettingItemType.settingItemTypeSwitchAction, isOn: true, callback: switchShake);

    list.add(acceptNotify);
    list.add(ring);
    list.add(shake);

    return list;
  }

  void switchNewMsgNotify(BuildContext context) {}

  void switchRing(BuildContext context) {}

  void switchShake(BuildContext context) {}
}
