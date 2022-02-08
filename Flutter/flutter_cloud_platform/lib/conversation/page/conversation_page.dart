import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_font.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_route.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_route_menu.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_button.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_image.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_title.dart';

class ConversationPage extends StatefulWidget {

  MCSRoute? route;

  ConversationPage({Key? key, this.route}) : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> with AutomaticKeepAliveClientMixin {

  List<Widget> _actions = [];

  @override
  void initState() {
    super.initState();
    _buildActions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MCSTitle('消息'),
        actions: _actions,
      ),
    );
  }

  void onTapMenu(MCSRouteMenu menu) {
    String route = menu.route ?? '';
    if (route.isEmpty) {
      return;
    }
    switch (route) {
      case search: {
        break;
      }
      case contactsList2: {
        break;
      }
      case selectContacts: {
        break;
      }
      case addFriend: {
        break;
      }
      case scan: {
        break;
      }
    }
  }

  void _buildActions() {
    Iterable<Widget>? iterable = widget.route?.menus?.where((MCSRouteMenu menu) {
      bool flag = menu.hiddenAction ?? true;
      return !flag;
    }).map((MCSRouteMenu menu) {
      IconButton button = IconButton(
          onPressed: () {
            onTapMenu(menu);
          },
          icon: MCSImage.cached(
            imageUrl: menu.icon ?? '',
            width: MCSLayout.menuIconSize,
            height: MCSLayout.menuIconSize,
          )
      );
      return button;
    }).toList().reversed;

    _actions.addAll(iterable ?? []);

    List<MCSRouteMenu>? foldMenus = widget.route?.menus?.where((MCSRouteMenu menu) {
      bool flag = menu.hiddenAction ?? false;
      return flag;
    }).toList();

    String url = widget.route?.overflowIcon ?? '';
    int count = foldMenus?.length ?? 0;
    if (url.isNotEmpty && count > 0) {
      PopupMenuButton button = PopupMenuButton(
        offset: const Offset(0, 50),
        itemBuilder: (context) {
          return foldMenus!.map((MCSRouteMenu menu) {
            return PopupMenuItem(
                padding: EdgeInsets.zero,
                child: MCSButton(
                  color: Colors.white,
                  elevation: 0.0,
                  highlightElevation: 0.0,
                  textPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  leftIcon: MCSImage.cached(
                    imageUrl: menu.icon ?? '',
                    width: MCSLayout.listMenuIconSize,
                    height: MCSLayout.listMenuIconSize,
                  ),
                  label: Text(
                    menu.name ?? '',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: fontLevel0
                    ),
                  ),
                  onPressed: () {
                    onTapMenu(menu);
                  },
                )
            );
          }).toList();
        },
        icon: MCSImage.cached(
          imageUrl: url,
          width: MCSLayout.menuIconSize,
          height: MCSLayout.menuIconSize,
        ),
      );
      _actions.add(button);
    }
  }

  @override
  bool get wantKeepAlive => true;
}
