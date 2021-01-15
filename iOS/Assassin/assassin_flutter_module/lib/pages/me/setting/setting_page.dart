import 'package:assassin_flutter_module/channels/application_configuration_channel.dart';
import 'package:assassin_flutter_module/constants.dart';
import 'package:assassin_flutter_module/pages/me/models/setting_item.dart';
import 'package:flutter/material.dart';
import 'package:assassin_flutter_module/pages/me/models/account.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<SettingItem> list = _initialData();
    Color themeColor = ApplicationConfigurationChannel.shared.fetchThemeColorSync();

    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
        backgroundColor: themeColor,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            SettingItem item = list[index];
            if (item.type == SettingItemType.settingItemTypeDesc) {
              return ListTile(
                title: item.title != null? Text(item.title, style: TextStyle(fontSize: font_size_level_3),): null,
                trailing: item.description != null? Text(item.description, style: TextStyle(fontSize: font_size_level_3, color: Colors.grey)): null,
                onTap: () => (item.callback(context))
              );
            } else if (item.type == SettingItemType.settingItemTypePushAction) {
              return ListTile(
                title: item.title != null? Text(item.title, style: TextStyle(fontSize: font_size_level_3)): null,
                trailing: Icon(Icons.arrow_forward_ios, size: 14.0,),
                onTap: () => (item.callback(context))
              );
            } else if (item.type == SettingItemType.settingItemTypeDivide) {
              return Container(
                height: default_margin,
                color: widget_bg_color,
              );
            } else {
              return Container();
            }
          },
          separatorBuilder: (context, index) {
            return Divider(height: divide_height, indent: divide_indent,);
          },
          itemCount: list.length,
      )
    );
  }

  List<SettingItem> _initialData() {
    List<SettingItem> list = List();

    Account acc = ApplicationConfigurationChannel.shared.fetchAccountSync();

    SettingItem account = SettingItem(title: "我的账号", description: acc.nickname ?? "", type: SettingItemType.settingItemTypeDesc);
    SettingItem nickname = SettingItem(title: "名称", description: acc.username ?? "", type: SettingItemType.settingItemTypeDesc);

    SettingItem divide = SettingItem(type: SettingItemType.settingItemTypeDivide);

    SettingItem modify = SettingItem(title: "修改密码", type: SettingItemType.settingItemTypePushAction, callback: modifyPassword);
    SettingItem live = SettingItem(title: "直播设置", type: SettingItemType.settingItemTypePushAction, callback: liveSetting);

    SettingItem businessCard = SettingItem(title: "名片", type: SettingItemType.settingItemTypePushAction, callback: showBusinessCard);
    SettingItem newMessage = SettingItem(title: "新消息提醒", type: SettingItemType.settingItemTypePushAction, callback: msgTipsSetting);
    SettingItem chat = SettingItem(title: "聊天", type: SettingItemType.settingItemTypePushAction, callback: chatSetting);
    SettingItem font = SettingItem(title: "字体大小", type: SettingItemType.settingItemTypePushAction, callback: fontSetting);

    SettingItem expression = SettingItem(title: "表情", type: SettingItemType.settingItemTypePushAction, callback: expressionManage);
    SettingItem clear = SettingItem(title: "清理存储空间", type: SettingItemType.settingItemTypePushAction, callback: clearSpace);

    SettingItem update = SettingItem(title: "检查更新", type: SettingItemType.settingItemTypePushAction, callback: checkUpdate);
    SettingItem about = SettingItem(title: "关于刺客", type: SettingItemType.settingItemTypePushAction, callback: aboutAssassin);

    list.add(account);
    list.add(nickname);
    list.add(divide);

    list.add(modify);
    list.add(live);
    list.add(divide);

    list.add(businessCard);
    list.add(newMessage);
    list.add(chat);
    list.add(font);
    list.add(divide);

    list.add(expression);
    list.add(clear);
    list.add(divide);

    list.add(update);
    list.add(about);
    list.add(divide);

    return list;
  }

  void modifyPassword(BuildContext context) {
    print("修改密码");
  }

  void liveSetting(BuildContext context) {
    print("直播设置");
  }

  void showBusinessCard(BuildContext context) {
    print("名片");
  }

  void msgTipsSetting(BuildContext context) {
    Navigator.pushNamed(context, route_name_new_msg_tip);
  }

  void chatSetting(BuildContext context) {
    print("聊天");
  }

  void fontSetting(BuildContext context) {
    print("字体大小");
  }

  void expressionManage(BuildContext context) {
    print("表情");
  }

  void clearSpace(BuildContext context) {
    print("清理存储空间");
  }

  void checkUpdate(BuildContext context) {
    print("更新");
  }

  void aboutAssassin(BuildContext context) {
    print("关于刺客");
  }
}
