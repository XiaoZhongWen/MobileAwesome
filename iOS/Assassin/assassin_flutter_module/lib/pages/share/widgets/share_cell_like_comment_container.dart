import 'package:assassin_flutter_module/constants.dart';
import 'package:assassin_flutter_module/pages/share/models/share_comment.dart';
import 'package:assassin_flutter_module/pages/share/models/share_comments_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_good.dart';
import 'package:assassin_flutter_module/pages/share/models/share_goods_provider.dart';
import 'package:assassin_flutter_module/pages/share/widgets/share_cell_comment.dart';
import 'package:assassin_flutter_module/pages/share/widgets/share_cell_like.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ShareCellLikeCommentContainer extends StatefulWidget {
  @override
  _ShareCellLikeCommentContainerState createState() => _ShareCellLikeCommentContainerState();
}

class _ShareCellLikeCommentContainerState extends State<ShareCellLikeCommentContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: share_portrait_size + default_margin),
      child: Consumer2<ShareGoodsProvider, ShareCommentsProvider>(
        builder: (context, ShareGoodsProvider goodsProvider, ShareCommentsProvider commentsProvider, _) {
          int goodsCount = goodsProvider.goods.length;
          int commentsCount = commentsProvider.comments.length;
          bool isShowLine = goodsCount > 0 && commentsCount > 0;
          if (goodsCount == 0 && commentsCount == 0) {
            return Container();
          }
          return Column(
            children: [
              Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 5,
                      child: Stack(
                        children: [
                          Positioned(
                            child: Icon(Icons.arrow_drop_up_rounded, color: Colors.grey.shade200,),
                            bottom: -10,
                            left: 10,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(share_feed_image_radius),
                child: Container(
                  color: Colors.grey.shade200,
                  child: Column(
                    children: [
                      goodsCount > 0? ShareCellLike() : Container(),
                      isShowLine? Divider(height: divide_height, indent: default_margin, endIndent: default_margin,): Container(),
                      commentsCount > 0? ShareCellComment(): Container()
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
