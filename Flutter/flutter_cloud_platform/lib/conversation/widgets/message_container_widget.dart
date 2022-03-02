import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/cache/mcs_memory_cache.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_asset_image.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_image.dart';
import 'package:flutter_cloud_platform/contacts/providers/contacts_provider.dart';
import 'package:flutter_cloud_platform/conversation/models/mcs_message.dart';
import 'package:flutter_cloud_platform/conversation/widgets/info_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_cloud_platform/base/extension/extension.dart';

class MessageContainerWidget extends StatefulWidget {
  const MessageContainerWidget(this.message, {Key? key}) : super(key: key);

  final MCSMessage message;

  @override
  _MessageContainerWidget createState() => _MessageContainerWidget();
}

class _MessageContainerWidget extends State<MessageContainerWidget> {
  @override
  Widget build(BuildContext context) {
    String info = '';
    switch (widget.message.type) {
      case MCSMessageType.unknown: {
        info = '该消息无法解析, 请申请到最新版本';
        break;
      }
      case MCSMessageType.time: {
        info = widget.message.timestamp.chatTime;
        break;
      }
    }

    if (info.isNotEmpty) {
      return InfoWidget(info);
    } else {
      String accountId = MCSMemoryCache.singleton.fetchAccountId()!;
      bool isIncoming = accountId != widget.message.sender;

      Widget header = _buildHeader(isIncoming? widget.message.peerID: accountId);
      Widget messageWidget = _buildMessageWidget(isIncoming);
      List<Widget> children = [header, MCSLayout.hGap5, messageWidget];
      return Padding(
        padding: EdgeInsets.all(MCSLayout.smallPadding),
        child: Row(
          mainAxisAlignment: isIncoming? MainAxisAlignment.start: MainAxisAlignment.end,
          children: isIncoming? children: children.reversed.toList(),
        ),
      );
    }
  }

  Widget _buildHeader(String userId) {
    return Selector<ContactsProvider, String>(
      selector: (_, contactsProvider) => contactsProvider.fetchIconUrl(userId),
      shouldRebuild: (prev, next) => prev != next,
      builder: (_, iconUrl, __) {
        return iconUrl.isEmpty?
            ClipOval(
              child: MCSAssetImage(
                'contacts/contacts_header',
                width: MCSLayout.listIconSize,
                height: MCSLayout.listIconSize,
                fit: BoxFit.cover,
              ),
            ):
            ClipOval(
              child: MCSImage.cached(
                imageUrl: iconUrl,
                width: MCSLayout.listIconSize,
                height: MCSLayout.listIconSize,
                fit: BoxFit.cover,
              ),
            );
      },
    );
  }

  Widget _buildMessageWidget(bool isIncoming) {
    Widget messageWidget = Container();
    switch (widget.message.type) {
      case MCSMessageType.text: {
        messageWidget = _buildTextMessageWidget(isIncoming);
        break;
      }
    }
    return messageWidget;
  }

  Widget _buildTextMessageWidget(bool isIncoming) {
    double maxWidth = context.width * 2 / 3;
    return Bubble(
      alignment: isIncoming? Alignment.topLeft: Alignment.topRight,
      nip: isIncoming? BubbleNip.leftCenter: BubbleNip.rightCenter,
      color: isIncoming? Colors.white: MCSColors.rightMessageBubbleColor,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth
        ),
        child: Text(widget.message.textElem?.text ?? ''),
      )
    );
  }
}
