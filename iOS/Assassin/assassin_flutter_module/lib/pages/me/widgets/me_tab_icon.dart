import 'package:assassin_flutter_module/constants.dart';
import 'package:assassin_flutter_module/pages/me/models/me_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef ActionCallBack = void Function(int type);

class MeTabIcon extends StatelessWidget {
  final MeTab _tab;
  final ActionCallBack _actionCallBack;
  MeTabIcon(this._tab, this._actionCallBack);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _iconButton(),
                Container(
                  child: Text(_tab.name, style: TextStyle(
                      fontSize: font_size_level_2,
                      fontWeight: font_weight_level_4
                  ),),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _iconButton() {
    if (_tab.iconUrl.isNotEmpty) {
      return IconButton(icon: Image.network(_tab.iconUrl, width: me_tab_icon_size, height: me_tab_icon_size), onPressed: () => _actionCallBack(int.parse(_tab.type)));
    } else {
      String imageName = "pic_null.png";
      if (_tab.type == "0") {
        imageName = "images/icon_myspace.png";
      } else if (_tab.type == "1") {
        imageName = "images/icon_mywork.png";
      } else if (_tab.type == "2") {
        imageName = "images/icon_mydischarge.png";
      } else if (_tab.type == "3") {
        imageName = "images/icon_mycloud.png";
      } else if (_tab.type == "4") {
        imageName = "images/icon_myassistants.png";
      } else if (_tab.type == "5") {
        imageName = "images/icon_myapplication.png";
      } else if (_tab.type == "6") {
        imageName = "images/icon_collect.png";
      } else if (_tab.type == "7") {
        imageName = "images/icon_setting.png";
      }
      return IconButton(icon: Image.asset(imageName, width: me_tab_icon_size, height: me_tab_icon_size,), onPressed: () => _actionCallBack(int.parse(_tab.type)));
    }
  }
}
