import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/goods/page/goods_page.dart';
import 'package:flutter_deer/order/page/order_page.dart';
import 'package:flutter_deer/res/Dimens.dart';
import 'package:flutter_deer/res/fd_colors.dart';
import 'package:flutter_deer/statistics/page/statistics_page.dart';
import 'package:flutter_deer/store/page/store_page.dart';
import 'package:flutter_deer/util/theme_utils.dart';

class Home extends StatefulWidget {
  const Home({Key? key}): super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  PageController _pageController = PageController();

  int _currentIndex = 0;
  List<Widget> _pageList = [];
  List<BottomNavigationBarItem> itmes = [];
  List<BottomNavigationBarItem> darkItems = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    bool isDark = ThemeUtils.isDark(context);

    print("home rebuild");

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: isDark? darkItems: itmes,
        backgroundColor: context.backgroundColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        iconSize: 21.0,
        selectedFontSize: Dimens.font_sp10,
        unselectedFontSize: Dimens.font_sp10,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: isDark ? FdColors.dark_unselected_item_color : FdColors.unselected_item_color,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: _pageList,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  void initData() {
    _pageList = [
      OrderPage(),
      GoodsPage(),
      StatisticsPage(),
      StorePage()
    ];

    itmes = [
      OrderPage.bottomNavigationBarItem(),
      GoodsPage.bottomNavigationBarItem(),
      StatisticsPage.bottomNavigationBarItem(),
      StorePage.bottomNavigationBarItem()
    ];

    darkItems = [
      OrderPage.darkBottomNavigationBarItem(),
      GoodsPage.darkBottomNavigationBarItem(),
      StatisticsPage.darkBottomNavigationBarItem(),
      StorePage.darkBottomNavigationBarItem()
    ];
  }
}