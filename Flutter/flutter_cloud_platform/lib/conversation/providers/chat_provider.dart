import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_platform.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_chat_route_setting.dart';
import 'package:flutter_cloud_platform/conversation/models/chat_operation_menu_item.dart';
import 'package:flutter_cloud_platform/base/extension/extension.dart';

class ChatProvider extends ChangeNotifier {
  ChatProvider(this.userId);

  final String userId;
  String? _nickname;
  bool? _isFold;
  List<ChatOperationMenuItem> _allMenuItems = [];

  String get nickname {
    return _nickname ?? userId;
  }

  bool get isFold {
    return _isFold ?? true;
  }

  set isFold(bool value) {
    _isFold = value;
  }

  List<ChatOperationMenuItem> fetchOperationItems({
    bool? isSecretConversation,
    MCSChatRouteSetting? setting,
    String? uid
  }) {
    if (userId.isPublicAccountId() || userId.isServiceAccountId()) {
      return [
        ChatOperationMenuItemType.picture,
        ChatOperationMenuItemType.camera,
        ChatOperationMenuItemType.video,
      ].map((e) => ChatOperationMenuItem(e)).toList();
    }
    if (isSecretConversation ?? false) {
      return [
        ChatOperationMenuItemType.picture,
        ChatOperationMenuItemType.camera,
        ChatOperationMenuItemType.video,
        ChatOperationMenuItemType.gif,
      ].map((e) => ChatOperationMenuItem(e)).toList();
    }
    if (_allMenuItems.isEmpty) {
      List<ChatOperationMenuItemType> types = [
        ChatOperationMenuItemType.picture,
        ChatOperationMenuItemType.camera,
        ChatOperationMenuItemType.video,
        ChatOperationMenuItemType.aiMeeting,
        ChatOperationMenuItemType.videoMeeting,
        ChatOperationMenuItemType.audioVideoCall,
        ChatOperationMenuItemType.gif,
        ChatOperationMenuItemType.location,
        ChatOperationMenuItemType.receiptMessage,
        ChatOperationMenuItemType.file,
        ChatOperationMenuItemType.approval,
        ChatOperationMenuItemType.journal,
        ChatOperationMenuItemType.task,
        ChatOperationMenuItemType.businessCard,
        ChatOperationMenuItemType.favorite,
        ChatOperationMenuItemType.secretConversation,
        ChatOperationMenuItemType.secretFile,
      ];
      for (var element in types) {
        if (!(BaiduMapKey.isEmpty &&
            element == ChatOperationMenuItemType.location)) {
          _allMenuItems.add(ChatOperationMenuItem(element));
        }
      }
      _allMenuItems.addAll(setting?.msgTypes ?? []);
    }
    List<ChatOperationMenuItem> list = List.from(_allMenuItems);
    List<ChatOperationMenuItemType> filter = [];
    if (uid != null && uid == userId) {
      filter.addAll([ChatOperationMenuItemType.videoMeeting,
        ChatOperationMenuItemType.audioVideoCall,
        ChatOperationMenuItemType.gif,
        ChatOperationMenuItemType.receiptMessage,
        ChatOperationMenuItemType.approval,
        ChatOperationMenuItemType.journal,
        ChatOperationMenuItemType.task,
        ChatOperationMenuItemType.aiMeeting,
        ChatOperationMenuItemType.secretConversation,
        ChatOperationMenuItemType.secretFile,
      ]);
    }

    if (userId.isGroupId()) {
      filter.addAll([ChatOperationMenuItemType.audioVideoCall,
        ChatOperationMenuItemType.secretConversation]);
    }

    if (userId.isMassId()) {
      filter.addAll([ChatOperationMenuItemType.audioVideoCall,
        ChatOperationMenuItemType.secretConversation,
        ChatOperationMenuItemType.videoMeeting,
        ChatOperationMenuItemType.audioVideoCall]);
    }

    if (userId.isTextMeetingId()) {
      filter.addAll([ChatOperationMenuItemType.audioVideoCall,
        ChatOperationMenuItemType.secretConversation,
        ChatOperationMenuItemType.approval,
        ChatOperationMenuItemType.journal,
        ChatOperationMenuItemType.task,
        ChatOperationMenuItemType.videoMeeting,
        ChatOperationMenuItemType.audioVideoCall
      ]);
    }

    if (!userId.isGroupId() &&
        !userId.isMassId() &&
        !userId.isTextMeetingId()) {
      filter.addAll([ChatOperationMenuItemType.receiptMessage,
        ChatOperationMenuItemType.aiMeeting,
        ChatOperationMenuItemType.videoMeeting]);
    }

    if (userId.isPublicAccountManager()) {
      filter.addAll([ChatOperationMenuItemType.secretConversation,
        ChatOperationMenuItemType.videoMeeting]);
    }

    list.removeWhere((element) => filter.contains(element.menuType));
    return list;
  }
}