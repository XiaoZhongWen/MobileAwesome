import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_routes.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_chat_route_setting.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_route.dart';
import 'package:flutter_cloud_platform/base/providers/account_provider.dart';
import 'package:flutter_cloud_platform/base/providers/visual_provider.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_asset_image.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_button.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_image.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_title.dart';
import 'package:flutter_cloud_platform/contacts/providers/contacts_provider.dart';
import 'package:flutter_cloud_platform/conversation/models/chat_operation_menu_item.dart';
import 'package:flutter_cloud_platform/conversation/providers/chat_provider.dart';
import 'package:flutter_cloud_platform/base/extension/extension.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(this.userId, {Key? key}) : super(key: key);

  final String userId;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with SingleTickerProviderStateMixin {

  late ChatProvider _chatProvider;
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _chatProvider = ChatProvider(widget.userId);
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this
    );
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _chatProvider,
      child: Scaffold(
        appBar: AppBar(
          title: Selector<ContactsProvider, String>(
            selector: (_, contactsProvider) => contactsProvider.fetchNickname(widget.userId),
            shouldRebuild: (prev, next) => prev != next,
            builder: (_, nickname, __) {
              return MCSTitle(nickname, type: MCSTitleType.barTitle,);
            },
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: _buildChatList(),
                  ),
                  _buildChatFooter()
                ],
              )
            ],
          ),
        )
      ),
    );
  }

  Widget _buildChatList() {
    return Container(

    );
  }

  Widget _buildChatFooter() {
    return Column(
      children: [
        _buildInputContainer(),
        _buildOperationMenu()
      ],
    );
  }

  Widget _buildInputContainer() {
    double iconSize = 30.0;
    return Container(
      padding: EdgeInsets.symmetric(vertical: MCSLayout.smallPadding),
      decoration: const BoxDecoration(
        border: topGreyBorder,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {},
            icon: MCSAssetImage('chat/voice_input', width: iconSize, height: iconSize,),
          ),
          const Expanded(
            child: TextField(
              minLines: 1,
              maxLines: 5,
              enabled: true,
              decoration: InputDecoration(
                labelText: '输入发送内容'
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              _chatProvider.isFold = !(_chatProvider.isFold);
              _chatProvider.isFold?
                _animationController.reverse():
                _animationController.forward();
            },
            icon: MCSAssetImage('chat/unfold_input', width: iconSize, height: iconSize,),
          ),
        ],
      ),
    );
  }

  Widget _buildOperationMenu() {
    VisualProvider visualProvider = Provider.of<VisualProvider>(context, listen: false);
    AccountProvider accountProvider = Provider.of<AccountProvider>(context, listen: false);
    MCSRoute? route = visualProvider.fetchRoute(message);
    Map<String, dynamic> map = json.decode(route?.content ?? '');
    String? uid = accountProvider.currentAccount?.userId;
    MCSChatRouteSetting setting = MCSChatRouteSetting.fromJson(map);
    List<ChatOperationMenuItem> list = _chatProvider.fetchOperationItems(
        isSecretConversation: false,
        setting: setting,
        uid: uid
    );

    double ratio = 1.2;
    double height = (context.width / 4) / ratio;
    double end = 2 * height + MCSLayout.padding * 2;
    _animation = Tween(begin: 0.0, end: end)
        .animate(_animation);

    int itemCount = 8;
    int pageCount = list.length ~/ itemCount +
        ((list.length % itemCount == 0)? 0: 1);

    return AnimatedBuilder(
      animation: _animation,
      builder: (_, child) {
        return Container(
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: (_animation.value > 0.0)? Colors.grey: Colors.white,
                    width: 0.1
                )
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: MCSLayout.padding),
          height: _animation.value,
          child: child,
        );
      },
      child: PageView.builder(
          itemBuilder: (context, index) {
            int start = index * itemCount;
            int end = (list.length - start) >= itemCount?
            start + itemCount:
            list.length;
            List<ChatOperationMenuItem> subList = list.sublist(start, end);
            print(height);
            return GridView.count(
              crossAxisCount: itemCount ~/ 2,
              childAspectRatio: ratio,
              children: subList.map((menuItem) {
                double iconSize = height * 0.6;
                return MCSButton(
                    disabledColor: Colors.transparent,
                    textPadding: EdgeInsets.symmetric(vertical: MCSLayout.smallPadding),
                    label: MCSTitle(
                      menuItem.name ?? '',
                      type: MCSTitleType.btnTitleGray,
                    ),
                    topIcon: (menuItem.url?.isNotEmpty ?? false)?
                    MCSImage.cached(imageUrl: menuItem.url ?? '', width: iconSize, height: iconSize,):
                    MCSAssetImage(menuItem.icon ?? '', width: iconSize, height: iconSize)
                );
              }).toList(),
            );
          },
          itemCount: pageCount
      )
    );
  }
}

