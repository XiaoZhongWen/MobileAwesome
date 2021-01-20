import 'package:assassin_flutter_module/constants.dart';
import 'package:assassin_flutter_module/pages/share/models/share_good.dart';
import 'package:assassin_flutter_module/pages/share/models/share_goods_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ShareCellLike extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ShareGoodsProvider goodsProvider, _) {
        int count = goodsProvider.numberOfNicknameDisplayed(
            context,
            MediaQuery.of(context).size.width - share_portrait_size - 3 * default_margin,
            TextStyle(fontSize: font_size_level_1));
        return Container(
          child: goodsProvider.goods.length > 0
              ?
              Column(
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          children: listOfComponet(goodsProvider, count),
                        ),
                      )
                    ],
                  )
                ],
              )
              :
          null,
        );
      },
    );
  }

  List<Widget> listOfComponet(ShareGoodsProvider goodsProvider, int maxCount) {
    List<Widget> list = [IconButton(icon: Icon(Icons.thumb_up_alt_outlined, size: share_icon_size,), onPressed: null)];
    for (ShareGood good in goodsProvider.goods) {
      String str = good.cnname;
      if (good != goodsProvider.goods.last) {
        str += "、";
      }
      list.add(Text(str, style: TextStyle(fontSize: font_size_level_1),));
    }
    if (goodsProvider.goods.length != maxCount) {
      list.add(Text(" 等" + goodsProvider.goods.length.toString() + "人觉得很赞", style: TextStyle(fontSize: font_size_level_1),));
    }
    return list;
  }
}