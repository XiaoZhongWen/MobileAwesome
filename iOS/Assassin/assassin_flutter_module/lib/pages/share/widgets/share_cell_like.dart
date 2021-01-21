import 'package:assassin_flutter_module/channels/application_configuration_channel.dart';
import 'package:assassin_flutter_module/constants.dart';
import 'package:assassin_flutter_module/pages/share/models/share_good.dart';
import 'package:assassin_flutter_module/pages/share/models/share_goods_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ShareCellLike extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color themeColor = ApplicationConfigurationChannel.shared.fetchThemeColorSync();
    return Consumer(
      builder: (context, ShareGoodsProvider goodsProvider, _) {
        bool overflow = goodsProvider.isOverflow(
            context,
            MediaQuery.of(context).size.width - share_portrait_size - 3 * default_margin - share_icon_size * 4,
            TextStyle(fontSize: font_size_level_1));
        return Container(
          child: Column(
            children: [
              Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left:default_margin, right:default_margin, top: default_margin * 0.5, bottom: default_margin * 0.5),
                          child: Icon(
                            Icons.thumb_up_alt_outlined,
                            size: share_icon_size,
                            color: themeColor,
                          ),
                        ),
                        Text.rich(
                            TextSpan(
                                children: [
                                  TextSpan(
                                      text: goodsProvider.nicknames,
                                      style: TextStyle(
                                          color: themeColor,
                                          fontSize: font_size_level_1
                                      )
                                  ),
                                  TextSpan(
                                    text: goodsProvider.desc,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: font_size_level_1
                                    ),
                                  ),
                                ]
                            )
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          )
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