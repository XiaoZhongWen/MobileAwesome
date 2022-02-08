import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_font.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_route.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_route_menu.dart';
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
                child: SizedBox(
                  width: 80,
                  child: ListTile(
                    dense: true,
                    horizontalTitleGap: 0,
                    minVerticalPadding: 0,
                    contentPadding: EdgeInsets.zero,
                    leading: SizedBox(
                      height: MCSLayout.menuIconSize,
                      child: MCSImage.cached(
                        imageUrl: menu.icon ?? '',
                        width: MCSLayout.listMenuIconSize,
                        height: MCSLayout.listMenuIconSize,
                      ),
                    ),
                    title: Text(
                      menu.name ?? '',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: fontLevel0
                      ),
                    ),
                  ),
                ),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MCSTitle('消息'),
        actions: _actions,
      ),
    );
  }

  void onTapMenu(MCSRouteMenu menu) {

  }

  void onTapFoldMenu() {

  }

  @override
  bool get wantKeepAlive => true;
}
