import 'package:flutter_cloud_platform/contacts/models/contacts_group_item.dart';

enum ContactsGroupType {
  other,
  friend
}

extension GroupName on ContactsGroupType {
  String get value => ['', '我的好友'][index];
}

class ContactsGroup {

  ContactsGroup(this.content);

  factory ContactsGroup.fromJson(Map<String, dynamic> json) {
    List<dynamic> items = json['content'];
    List<ContactsGroupItem> list = items.map((map) => ContactsGroupItem.fromJson(map)).toList();
    return ContactsGroup(list);
  }

  List<ContactsGroupItem>? content;
}