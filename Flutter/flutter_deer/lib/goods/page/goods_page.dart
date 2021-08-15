import 'package:flutter/cupertino.dart';
import 'package:flutter_deer/res/fd_colors.dart';
import 'package:flutter_deer/widgets/load_image.dart';

class GoodsPage extends StatefulWidget {
  static String title = "商品";

  static bottomNavigationBarItem() {
    double size = 25.0;
    return BottomNavigationBarItem(
        icon: LoadAssetImage("/home/icon_commodity", width: size, height: size, color: FdColors.unselected_item_color,),
        activeIcon: LoadAssetImage("/home/icon_commodity", width: size, height: size, color: FdColors.app_main,),
        label: title
    );
  }

  static darkBottomNavigationBarItem() {
    double size = 25.0;
    return BottomNavigationBarItem(
        icon: LoadAssetImage("/home/icon_commodity", width: size, height: size),
        activeIcon: LoadAssetImage("/home/icon_commodity", width: size, height: size, color: FdColors.dark_app_main,),
        label: title
    );
  }

  _GoodsPageState createState() => _GoodsPageState();
}

class _GoodsPageState extends State<GoodsPage> with AutomaticKeepAliveClientMixin<GoodsPage> {

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {

    print("goods rebuild");
    return Center(
      child: Text(GoodsPage.title),
    );
  }
}