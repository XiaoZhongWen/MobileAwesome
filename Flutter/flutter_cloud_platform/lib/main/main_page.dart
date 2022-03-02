import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/cache/mcs_memory_cache.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_font.dart';
import 'package:flutter_cloud_platform/base/dao/account_dao.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_route.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_tab.dart';
import 'package:flutter_cloud_platform/base/providers/account_provider.dart';
import 'package:flutter_cloud_platform/base/providers/provider.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_asset_image.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_image.dart';
import 'package:flutter_cloud_platform/contacts/page/contacts_page.dart';
import 'package:flutter_cloud_platform/conversation/page/conversation_page.dart';
import 'package:flutter_cloud_platform/main/providers/main_provider.dart';
import 'package:flutter_cloud_platform/mine/page/mine_page.dart';
import 'package:flutter_cloud_platform/office/page/office_page.dart';
import 'package:flutter_cloud_platform/share/page/share_page.dart';
import 'package:flutter_cloud_platform/web/page/web_page.dart';
import 'package:flutter_cloud_platform/base/extension/extension.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with RestorationMixin {

  final MainProvider _mainProvider = MainProvider(0);
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    AccountProvider provider = Provider.of<AccountProvider>(context, listen: false);
    AccountDao dao = AccountDao();
    dao.fetchLastTimeAccount().then((account) {
      provider.update(account);
    });
  }

  @override
  Widget build(BuildContext context) {
    MCSMemoryCache.singleton.store(screenWidthKey, context.width);
    MCSMemoryCache.singleton.store(screenHeightKey, context.height);
    return Consumer<VisualProvider>(builder: (_, visualProvider, __) {
      List<Widget> pageList = _buildPageList(visualProvider.tabs());
      List<BottomNavigationBarItem> items = _buildBottomNavigationBarItems(
          visualProvider.tabs(),
          visualProvider.tabIconTable(),
          visualProvider.selectedTabIconTable()
      );
      return pageList.isEmpty? Container(): ChangeNotifierProvider.value(
        value: _mainProvider,
        child: Scaffold(
          bottomNavigationBar: Consumer<MainProvider>(builder: (_, mainProvider, __) {
            return BottomNavigationBar(
              items: items,
              type: BottomNavigationBarType.fixed,
              currentIndex: mainProvider.value,
              onTap: (int index) {
                _pageController.jumpToPage(index);
              },
              selectedItemColor: MCSColors.mainColor,
              selectedFontSize: tabFontSize,
            );
          }),
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (int pageIndex) {
              _mainProvider.value = pageIndex;
            },
            children: pageList,
          ),
        ),
      );
    });
  }

  List<BottomNavigationBarItem> _buildBottomNavigationBarItems(
      List<MCSTab?>? tabs,
      Map<String, String> tabIconTable,
      Map<String, String> selectedTabIconTable,) {
    int tabCount = tabs?.length ?? 0;
    List<BottomNavigationBarItem> list = [];
    for(int i = 0; i < tabCount; i++) {
      MCSTab? tab = tabs?[i];
      String tabUrl = tab?.unselIcon ?? '';
      String selectedTabUrl = tab?.selIcon ?? '';
      Widget? icon;
      Widget? selectedIcon;
      if (tabUrl.isEmpty || selectedTabUrl.isEmpty) {
        String route = tab?.route ?? '';
        String tabIconPath = tabIconTable[route] ?? '';
        String selectedTabIconPath = selectedTabIconTable[route] ?? '';
        if (tabIconPath.isNotEmpty && selectedTabIconPath.isNotEmpty) {
          icon = MCSAssetImage(tabIconPath, width: MCSLayout.tabIconSize,height: MCSLayout.tabIconSize);
          selectedIcon = MCSAssetImage(selectedTabIconPath, width: MCSLayout.tabIconSize,height: MCSLayout.tabIconSize);
        }
      } else {
        icon = MCSImage.cached(imageUrl: tabUrl, width: MCSLayout.tabIconSize,height: MCSLayout.tabIconSize);
        selectedIcon = MCSImage.cached(imageUrl: selectedTabUrl, width: MCSLayout.tabIconSize,height: MCSLayout.tabIconSize);
      }
      if (icon != null && selectedIcon != null) {
        BottomNavigationBarItem item = BottomNavigationBarItem(
          icon: icon,
          activeIcon: selectedIcon,
          label: tab?.name ?? ''
        );
        list.add(item);
      }
    }
    return list;
  }

  List<Widget> _buildPageList(List<MCSTab?>? tabs) {
    List<Widget> list = [];
    int tabCount = tabs?.length ?? 0;
    for(int i = 0; i < tabCount; i++) {
      MCSTab? tab = tabs?[i];
      String route = tab?.route ?? '';
      Widget? page;
      switch (route) {
        case contactsList1:{
          page = ContactsPage();
          break;
        }
        case conversation: {
          page = ConversationPage();
          break;
        }
        case share1: {
          page = const SharePage();
          break;
        }
        case office1: {
          page = const OfficePage();
          break;
        }
        case mine1: {
          page = const MinePage();
          break;
        }
        case web: {
          page = const WebPage();
          break;
        }
      }
      if (page != null) {
        list.add(page);
      }
    }
    return list;
  }

  @override
  String? get restorationId => 'main';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_mainProvider, 'BottomNavigationBarCurrentIndex');
  }
}
