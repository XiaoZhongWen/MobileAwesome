import 'package:flutter/cupertino.dart';

enum SettingItemType {
  settingItemTypeDesc,
  settingItemTypePushAction,
  settingItemTypeSwitchAction,
  settingItemTypeDivide
}

class SettingItem {
  final String title;
  final String description;
  final SettingItemType type;
  bool isOn;
  final void Function(BuildContext context) callback;

  SettingItem({this.title, this.description, this.type, this.isOn, this.callback});
}