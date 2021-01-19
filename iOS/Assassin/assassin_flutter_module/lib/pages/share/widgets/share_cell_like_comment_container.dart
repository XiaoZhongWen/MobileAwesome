import 'package:assassin_flutter_module/constants.dart';
import 'package:assassin_flutter_module/pages/share/models/share_comment.dart';
import 'package:assassin_flutter_module/pages/share/models/share_good.dart';
import 'package:assassin_flutter_module/pages/share/widgets/share_cell_comment.dart';
import 'package:assassin_flutter_module/pages/share/widgets/share_cell_like.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShareCellLikeCommentContainer extends StatefulWidget {
  @override
  _ShareCellLikeCommentContainerState createState() => _ShareCellLikeCommentContainerState();
}

class _ShareCellLikeCommentContainerState extends State<ShareCellLikeCommentContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: share_portrait_size + default_margin),
      child: Column(
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
                  ShareCellLike(),
                  ShareCellComment()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
