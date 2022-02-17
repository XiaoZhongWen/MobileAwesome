enum ChatOperationMenuItemType {
  picture,
  camera,
  video,
  videoMeeting,
  audioVideoCall,
  gif,
  location,
  receiptMessage,
  file,
  approval,
  journal,
  task,
  businessCard,
  favorite,
  aiMeeting,
  secretConversation,
  secretFile,
  custom
}

extension Ex on ChatOperationMenuItemType {
  String get value => [
    '照片',
    '拍照',
    '小视频',
    '视频会议',
    '音视频通话',
    '表情',
    '位置',
    '回执消息',
    '文件',
    '审批',
    '简报',
    '任务',
    '名片',
    '我的收藏',
    '智能会议',
    '机密会话',
    '机密文件'][index];

  String get icon => [
    'chat/chat_menu_picture',
    'chat/chat_menu_camera',
    'chat/chat_menu_video',
    'chat/chat_menu_audio_video_meeting',
    'chat/chat_menu_audio_video_meeting',
    'chat/chat_menu_gif',
    'chat/chat_menu_location',
    'chat/chat_menu_receipt_message',
    'chat/chat_menu_file',
    'chat/chat_menu_approval',
    'chat/chat_menu_journal',
    'chat/chat_menu_task',
    'chat/chat_menu_business_card',
    'chat/chat_menu_favorite',
    'chat/chat_menu_ai_meeting',
    'chat/chat_menu_secret_conversation',
    'chat/chat_menu_secret_file',
    'chat/default_chat_menu_icon'
  ][index];
}

class ChatOperationMenuItem {
  ChatOperationMenuItem(this.menuType, {this.url, this.route, this.type, this.name, this.icon}) {
    if (menuType != ChatOperationMenuItemType.custom) {
      name = menuType.value;
      icon = menuType.icon;
    }
  }

  factory ChatOperationMenuItem.fromJson(Map<String, dynamic> map) {
    String? url = map['url'];
    String? route = map['route'];
    String? type = map['type'];
    String? name = map['name'];
    String? icon = map['icon'];
    return ChatOperationMenuItem(
        ChatOperationMenuItemType.custom,
        url: url,
        route: route,
        type: type,
        name: name,
        icon: icon
    );
  }

  ChatOperationMenuItemType menuType;
  String? url;
  String? route;
  String? type;
  String? name;
  String? icon;
}