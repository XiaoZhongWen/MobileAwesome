import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/res/fd_colors.dart';
import 'package:flutter_deer/widgets/load_image.dart';

class OrderPage extends StatefulWidget {

  static String title = "订单";

  static bottomNavigationBarItem() {
    double size = 25.0;
    return BottomNavigationBarItem(
        icon: LoadAssetImage("/home/icon_order", width: size, height: size, color: FdColors.unselected_item_color,),
        activeIcon: LoadAssetImage("/home/icon_order", width: size, height: size, color: FdColors.app_main,),
        label: title
    );
  }

  static darkBottomNavigationBarItem() {
    double size = 25.0;
    return BottomNavigationBarItem(
        icon: LoadAssetImage("/home/icon_order", width: size, height: size),
        activeIcon: LoadAssetImage("/home/icon_order", width: size, height: size, color: FdColors.dark_app_main,),
        label: title
    );
  }

  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with AutomaticKeepAliveClientMixin<OrderPage> {

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
              child: SizedBox(
                height: 105,
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [FdColors.gradient_blue, Color(0xFF4647FA)]),
                  ),
                ),
              )
          ),
          Container(
            width: double.infinity,
            color: Colors.yellow,
          )
        ],
      ),
    );
  }

}