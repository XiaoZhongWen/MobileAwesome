import 'package:assassin_flutter_module/channels/application_configuration_channel.dart';
import 'package:assassin_flutter_module/constants.dart';
import 'package:assassin_flutter_module/pages/share/models/share_callbacks_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_comment.dart';
import 'package:assassin_flutter_module/pages/share/models/share_comments_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ShareCellComment extends StatelessWidget {

  TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();

  @override
  Widget build(BuildContext context) {
    Color themeColor = ApplicationConfigurationChannel.shared.fetchThemeColorSync();
    return Consumer2<ShareCommentsProvider, ShareCallbacksProvider>(
      builder: (context, ShareCommentsProvider commentsProvider, ShareCallbacksProvider callbacksProvider, _) {
        return Container(
          padding: EdgeInsets.only(left: default_margin, top: default_margin, bottom: default_margin),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: commentsProvider.comments.length,
            itemBuilder: (BuildContext context, int index) {
              ShareComment shareComment = commentsProvider.comments[index];
              return Text.rich(
                TextSpan(
                    children: [
                      TextSpan(
                        text: shareComment.cnname + ": ",
                        recognizer: _tapGestureRecognizer
                        ..onTap = () => callbacksProvider.onTapNickname(shareComment.replier),
                        style: TextStyle(
                            color: themeColor,
                            fontSize: font_size_level_1
                        ),
                      ),
                      TextSpan(
                        text: shareComment.content,
                        style: TextStyle(
                            fontSize: font_size_level_1
                        ),
                      )
                    ]
                ),
              );
            },
          )
        );
      },
    );
  }
}
