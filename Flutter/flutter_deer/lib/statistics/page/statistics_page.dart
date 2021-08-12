import 'package:flutter/cupertino.dart';
import 'package:flutter_deer/res/fd_colors.dart';
import 'package:flutter_deer/widgets/load_image.dart';

class StatisticsPage extends StatefulWidget {
  static String title = "统计";

  static bottomNavigationBarItem() {
    double size = 25.0;
    return BottomNavigationBarItem(
        icon: LoadAssetImage("/home/icon_statistics", width: size, height: size, color: FdColors.unselected_item_color,),
        activeIcon: LoadAssetImage("/home/icon_statistics", width: size, height: size, color: FdColors.app_main,),
        label: title
    );
  }

  static darkBottomNavigationBarItem() {
    double size = 25.0;
    return BottomNavigationBarItem(
        icon: LoadAssetImage("/home/icon_statistics", width: size, height: size),
        activeIcon: LoadAssetImage("/home/icon_statistics", width: size, height: size, color: FdColors.dark_app_main,),
        label: title
    );
  }

  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> with AutomaticKeepAliveClientMixin {

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {

    print("statistics rebuild");
    return Center(
      child: Text(StatisticsPage.title),
    );
  }
}