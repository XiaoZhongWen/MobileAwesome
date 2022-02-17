import 'package:flutter_cloud_platform/conversation/models/chat_operation_menu_item.dart';

class MCSChatRouteSetting {

  MCSChatRouteSetting(this.needTextInputLayout, this.chatWatermark, this.msgTypes);

  factory MCSChatRouteSetting.fromJson(Map<String, dynamic> map) {
    bool? input = map['needTextInputLayout'] as bool?;
    bool? watermark = map['chatWatermark'] as bool?;
    List<Map<String, dynamic>>? list = map['msgTypes'] as List<Map<String, dynamic>>?;
    List<ChatOperationMenuItem>? types = list?.map((e) => ChatOperationMenuItem.fromJson(e)).toList();
    return MCSChatRouteSetting(input, watermark, types);
  }

  bool? needTextInputLayout;
  bool? chatWatermark;
  List<ChatOperationMenuItem>? msgTypes;
}