import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_font.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_route.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_route_menu.dart';
import 'package:flutter_cloud_platform/base/providers/provider.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_button.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_image.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_title.dart';
import 'package:flutter_cloud_platform/contacts/contacts_router.dart';
import 'package:flutter_cloud_platform/conversation/conversation_router.dart';
import 'package:flutter_cloud_platform/routes/mcs_navigator.dart';
import 'package:flutter_cloud_platform/scan/scan_router.dart';
import 'package:provider/provider.dart';

class ConversationPage extends StatefulWidget {

  ConversationPage({Key? key}) : super(key: key);

  @override
  _ConversationPageState createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> with AutomaticKeepAliveClientMixin {

  List<Widget> _actions = [];

  @override
  void initState() {
    super.initState();
    VisualProvider visualProvider = Provider.of<VisualProvider>(context, listen:false);
    MCSRoute? route = visualProvider.fetchRoute(conversation);
    _buildActions(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MCSTitle('消息', type: MCSTitleType.barTitle,),
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
        MCSNavigator.push(context, ConversationRouter.searchPage);
        break;
      }
      case contactsList2: {
        MCSNavigator.push(context, ContactsRouter.contactsPage);
        break;
      }
      case selectContacts: {
        MCSNavigator.push(context, ContactsRouter.selectContactsPage);
        break;
      }
      case addFriend: {
        MCSNavigator.push(context, ContactsRouter.addContactsPage);
        break;
      }
      case scan: {
        MCSNavigator.push(context, ScanRouter.scanPage);
        break;
      }
    }
  }

  void _buildActions(MCSRoute? route) {
    Iterable<Widget>? iterable = route?.menus?.where((MCSRouteMenu menu) {
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

    List<MCSRouteMenu>? foldMenus = route?.menus?.where((MCSRouteMenu menu) {
      bool flag = menu.hiddenAction ?? false;
      return flag;
    }).toList();

    String url = route?.overflowIcon ?? '';
    int count = foldMenus?.length ?? 0;
    if (url.isNotEmpty && count > 0) {
      PopupMenuButton button = PopupMenuButton(
        offset: const Offset(0, 50),
        color: Colors.white,
        onSelected: (Object? object) {
          MCSRouteMenu menu = object as MCSRouteMenu;
          onTapMenu(menu);
        },
        itemBuilder: (context) {
          return foldMenus!.map((MCSRouteMenu menu) {
            return PopupMenuItem(
                padding: EdgeInsets.zero,
                value: menu,
                child: MCSButton(
                  color: Colors.white,
                  disabledColor: Colors.white,
                  elevation: 0.0,
                  highlightElevation: 0.0,
                  mainAxisAlignment: MainAxisAlignment.start,
                  textPadding: EdgeInsets.symmetric(horizontal: MCSLayout.margin),
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
                  )
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
