import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/cache/mcs_memory_cache.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/providers/im_provider.dart';
import 'package:flutter_cloud_platform/base/service/mcs_sound_service.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_asset_image.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_image.dart';
import 'package:flutter_cloud_platform/contacts/providers/contacts_provider.dart';
import 'package:flutter_cloud_platform/conversation/models/mcs_message.dart';
import 'package:flutter_cloud_platform/conversation/widgets/cell/audio_message_cell.dart';
import 'package:flutter_cloud_platform/conversation/widgets/info_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_cloud_platform/base/extension/extension.dart';

class MessageContainerWidget extends StatefulWidget {
  const MessageContainerWidget(this.message, {Key? key}) : super(key: key);

  final MCSMessage message;

  @override
  _MessageContainerWidget createState() => _MessageContainerWidget();
}

class _MessageContainerWidget extends State<MessageContainerWidget> with SingleTickerProviderStateMixin {
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
      if (!isIncoming) {
        Widget indicator = const CupertinoActivityIndicator(radius: 5,);
        if (widget.message.status == MCSMessageStatus.sending) {
          children.add(indicator);
        }
      }
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
      case MCSMessageType.audio: {
        messageWidget = _buildAudioMessageWidget(isIncoming);
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

  Widget _buildAudioMessageWidget(bool isIncoming) {
    double maxWidth = context.width * 2 / 3;
    String filename = widget.message.audioElem?.fileName ?? '';
    String url = widget.message.audioElem?.url ?? '';
    IMProvider provider = Provider.of<IMProvider>(context, listen: false);

    return GestureDetector(
      onTap: () async {
        String key = MCSSoundService.singleton.currentKey();
        if (MCSSoundService.singleton.isPlaying()) {
          MCSSoundService.singleton.stopPlay();
          provider.updateMessageStatus(key, MessageStatusType.audioPlay);
        }
        if (key != widget.message.msgID) {
          await MCSSoundService.singleton.startPlay(
              key: widget.message.msgID,
              fileName: widget.message.audioElem?.fileName,
              url: widget.message.audioElem?.url,
              whenFinished: () {
                provider.updateMessageStatus(widget.message.msgID, MessageStatusType.audioPlay);
              }
          );
          provider.updateMessageStatus(widget.message.msgID, MessageStatusType.audioPlay);
        }
      },
      child: Bubble(
          alignment: isIncoming? Alignment.topLeft: Alignment.topRight,
          nip: isIncoming? BubbleNip.leftCenter: BubbleNip.rightCenter,
          color: isIncoming? Colors.white: MCSColors.rightMessageBubbleColor,
          child: ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: maxWidth
            ),
            child: Selector<IMProvider, int>(
              selector: (_, provider) => provider.fetchMessageStatus(widget.message.msgID, MessageStatusType.audioPlay),
              shouldRebuild: (prev, next) => prev != next,
              builder: (_, status, __) {
                return AudioMessageCell(
                  widget.message.msgID,
                  isIncoming,
                  widget.message.audioElem?.duration ?? 0,
                  filename,
                  url,
                );
              },
            ),
          )
      ),
    );
  }
}
