import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/cache/mcs_memory_cache.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_routes.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_chat_route_setting.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_route.dart';
import 'package:flutter_cloud_platform/base/providers/account_provider.dart';
import 'package:flutter_cloud_platform/base/providers/im_provider.dart';
import 'package:flutter_cloud_platform/base/providers/visual_provider.dart';
import 'package:flutter_cloud_platform/base/service/mcs_image_service.dart';
import 'package:flutter_cloud_platform/base/service/mcs_sound_service.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_asset_image.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_button.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_image.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_title.dart';
import 'package:flutter_cloud_platform/contacts/providers/contacts_provider.dart';
import 'package:flutter_cloud_platform/conversation/models/chat_operation_menu_item.dart';
import 'package:flutter_cloud_platform/conversation/models/mcs_message.dart';
import 'package:flutter_cloud_platform/conversation/providers/chat_provider.dart';
import 'package:flutter_cloud_platform/conversation/providers/input_status_provider.dart';
import 'package:flutter_cloud_platform/conversation/widgets/input_container_widget.dart';
import 'package:flutter_cloud_platform/conversation/widgets/message_container_widget.dart';
import 'package:flutter_cloud_platform/conversation/widgets/record_status_widget.dart';
import 'package:provider/provider.dart';
import 'package:mcs_photo_picker/mcs_photo_picker.dart';
import 'package:mcs_photo_picker/m_file.dart';

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
  final InputStatusProvider _inputStatusProvider = InputStatusProvider();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  final double loadingOffset = 100.0;
  final McsPhotoPicker _imagePicker = McsPhotoPicker();
  int _offset = 0;

  /*
  * 从左到右
  * 显示键盘、隐藏键盘、显示菜单、隐藏菜单
  *
  * */
  // int _actionType = 0x00;
  // final int _showKeyboard = 0x10;
  // final int _showOperationMenu = 0x01;

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
    _scrollController.dispose();
    _focusNode.dispose();
    MCSSoundService.singleton.stopPlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _chatProvider),
        ChangeNotifierProvider.value(value: _inputStatusProvider),
      ],
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
              child: GestureDetector(
                onTap: () {
                  _fold();
                },
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: _buildChatList(),
                        ),
                        _buildChatFooter()
                      ],
                    ),
                    Selector<InputStatusProvider, RecordStatus>(
                        selector: (_, provider) => provider.status,
                        shouldRebuild: (prev, next) => prev != next,
                        builder: (_, status, __) {
                          return Visibility(
                            child: const RecordStatusWidget(),
                            visible: (status == RecordStatus.recording ||
                                status == RecordStatus.canceling),
                          );
                        })
                  ],
                ),
              )
          )
      ),
    );
  }

  Widget _buildChatList() {
    IMProvider imProvider = Provider.of<IMProvider>(context, listen: false);
    imProvider.peerID = widget.userId;

    return FutureBuilder(
      future: imProvider.loadMessageList(_offset),
      builder: (_, snapshot) {
        switch(snapshot.connectionState) {
          case ConnectionState.done: {
            return NotificationListener(
                onNotification: (notification) {
                  if (notification is ScrollEndNotification) {
                    double maxScrollExtent = _scrollController.position.maxScrollExtent;
                    double offset = _scrollController.offset;
                    if (maxScrollExtent - offset < loadingOffset) {
                      imProvider.loadMessageList(_offset);
                    }
                    print("maxScrollExtent: " + maxScrollExtent.toString() + " - offset: " + offset.toString());
                  }
                  return false;
                },
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Selector<IMProvider, List<MCSMessage>>(
                      selector: (_, provider) => provider.fetchMessageList(_offset),
                      shouldRebuild: (prev, next) => prev.length != next.length,
                      builder: (_, datasource, __) {
                        int count = 0;
                        for (var element in datasource) {
                          if (element.type != MCSMessageType.time) {
                            count++;
                          }
                        }
                        _offset = count;
                        return ListView.builder(
                          reverse: true,
                          shrinkWrap: true,
                          controller: _scrollController,
                          itemBuilder: (_, index) => MessageContainerWidget(datasource[index]),
                          itemCount: datasource.length,
                        );
                      },
                    )
                )
            );
          }
          default: {
            return MCSLayout.hGap0;
          }
        }
      },
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
    IMProvider imProvider = Provider.of<IMProvider>(context, listen: false);
    ContactsProvider contactsProvider = Provider.of<ContactsProvider>(context, listen: false);
    return ChangeNotifierProvider.value(
      value: _inputStatusProvider,
      child: InputContainerWidget(
        sendTextMessage: (text) {
          imProvider.sendMessage(
              widget.userId,
              MCSMessageType.text,
              text: text,
              receiverName: contactsProvider.fetchNickname(widget.userId)
          );
          _scrollToBottom();
        },
        switchKeyboard: (isKeyboard) {
          _animationController.reverse();
        },
        switchFoldStatus: (isFold) {
          isFold? _animationController.reverse(): _animationController.forward();
        },
        sendAudioMessage: (String path, int duration) {
          imProvider.sendMessage(
            widget.userId,
            MCSMessageType.audio,
            localPath: path,
            duration: duration,
            receiverName: contactsProvider.fetchNickname(widget.userId)
          );
        },
        focusNode: _focusNode,
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
    double screenWidth = MCSMemoryCache.singleton.fetchScreenWidth() ?? 320.0;
    double height = (screenWidth / 4) / ratio;
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
            return GridView.count(
              crossAxisCount: itemCount ~/ 2,
              childAspectRatio: ratio,
              children: subList.map((menuItem) {
                double iconSize = height * 0.6;
                return MCSButton(
                  color: Colors.transparent,
                  disabledColor: Colors.transparent,
                  elevation: 0.0,
                  highlightElevation: 0.0,
                  textPadding: EdgeInsets.symmetric(vertical: MCSLayout.smallPadding),
                  label: MCSTitle(
                    menuItem.name ?? '',
                    type: MCSTitleType.btnTitleGray,
                  ),
                  topIcon: (menuItem.url?.isNotEmpty ?? false)?
                  MCSImage.cached(imageUrl: menuItem.url ?? '', width: iconSize, height: iconSize,):
                  MCSAssetImage(menuItem.icon ?? '', width: iconSize, height: iconSize),
                  onPressed: () {
                    _onTapMenu(menuItem.menuType);
                  },
                );
              }).toList(),
            );
          },
          itemCount: pageCount
      )
    );
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 250),
        curve: Curves.ease);
  }

  void _fold() {
    if (!_inputStatusProvider.isFold) {
      _inputStatusProvider.fold = true;
      _animationController.reverse();
    }
    if (_focusNode.hasFocus) {
      _focusNode.unfocus();
    }
  }

  void _onTapMenu(ChatOperationMenuItemType type) {
    switch (type) {
      case ChatOperationMenuItemType.picture: {
        _displayPhotoLibrary();
        break;
      }
      case ChatOperationMenuItemType.camera: {
        _takePicture();
        break;
      }
    }
  }

  void _displayPhotoLibrary() {
    _imagePicker.pickMultiImage().then((result) async {
      bool? original = result['original'] as bool?;
      List<MFile>? images = result['images'] as List<MFile>?;
      if (images != null && images.isNotEmpty) {
        if (!(original ?? false)) {
          for (var file in images) {
            List<String> list = await MCSImageService.singleton.compressImages([file.path]);
            file.path = list.first;
          }
        }
        IMProvider imProvider = Provider.of<IMProvider>(context, listen: false);
        ContactsProvider contactsProvider = Provider.of<ContactsProvider>(context, listen: false);
        for (var file in images) {
          imProvider.sendMessage(
              widget.userId,
              MCSMessageType.image,
              receiverName: contactsProvider.fetchNickname(widget.userId),
              file: file
          );
        }
      }
    });
  }

  void _takePicture() {
    _imagePicker.takePicture().then((mFile) {
      IMProvider imProvider = Provider.of<IMProvider>(context, listen: false);
      ContactsProvider contactsProvider = Provider.of<ContactsProvider>(context, listen: false);
      imProvider.sendMessage(
          widget.userId,
          MCSMessageType.image,
          receiverName: contactsProvider.fetchNickname(widget.userId),
          file: mFile
      );
    });
  }
}

