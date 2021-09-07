import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer/order/page/order_list_page.dart';
import 'package:flutter_deer/res/Dimens.dart';
import 'package:flutter_deer/res/fd_colors.dart';
import 'package:flutter_deer/util/image_utils.dart';
import 'package:flutter_deer/util/theme_utils.dart';
import 'package:flutter_deer/widgets/fd_card.dart';
import 'package:flutter_deer/widgets/fd_flexible_space_bar.dart';
import 'package:flutter_deer/widgets/load_image.dart';
import 'package:flutter_deer/res/styles.dart';
import 'package:flutter_deer/util/screen_util.dart';

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

class _OrderPageState extends State<OrderPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                title: const Text('Snapping Nested SliverAppBar', style: TextStyle(color: Colors.black),),
                expandedHeight: 200.0,
                forceElevated: innerBoxIsScrolled,
                floating: true,
                snap: true,
                // pinned: true,
                ),
              ),
          ];
        },
        body: Builder(
          builder: (BuildContext context) {
            return CustomScrollView(
              slivers: [
                SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
                SliverFixedExtentList(
                    itemExtent: 48,
                    delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          return ListTile(title: Text("item $index"),);
                        },
                        childCount: 30
                    )
                )
              ],
            );
          },
        )
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class Test extends StatelessWidget implements PreferredSizeWidget {

  final String text;

  Test({Key? key, required this.text}): super(key: key);

  @override
  Size get preferredSize => Size(double.infinity, 50);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(text),
    );
  }
}