import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/cache/mcs_memory_cache.dart';
import 'package:flutter_cloud_platform/contacts/providers/contacts_provider.dart';
import 'package:flutter_cloud_platform/conversation/models/mcs_message.dart';
import 'package:provider/provider.dart';

class MessageContainerWidget extends StatefulWidget {
  const MessageContainerWidget(this.message, {Key? key}) : super(key: key);

  final MCSMessage message;

  @override
  _MessageContainerWidget createState() => _MessageContainerWidget();
}

class _MessageContainerWidget extends State<MessageContainerWidget> {
  @override
  Widget build(BuildContext context) {
    String accountId = MCSMemoryCache.singleton.fetchAccountId()!;
    bool isIncoming = accountId != widget.message.sender;

    Widget header = _buildHeader();
    Widget messageWidget = _buildMessageWidget();
    return Row(
      mainAxisAlignment: isIncoming? MainAxisAlignment.start: MainAxisAlignment.end,
      children: [
        header,
        messageWidget
      ],
    );
  }

  Widget _buildHeader() {
    ContactsProvider contactsProvider = Provider.of<ContactsProvider>(context, listen: false);
    return Container();
  }

  Widget _buildMessageWidget() {
    Widget messageWidget = Container();
    switch (widget.message.type) {
      case MCSMessageType.unknown: {
        break;
      }
      case MCSMessageType.text: {
        break;
      }
    }
    return messageWidget;
  }
}
