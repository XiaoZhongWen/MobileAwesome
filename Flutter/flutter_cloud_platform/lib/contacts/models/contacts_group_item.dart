class ContactsGroupItem {

  /*
  * type:
  * public_layout 公众号
  * group_layout 群组
  * org_layout 组织架构
  * new_friends_layout 新的好友
  * */

  ContactsGroupItem(this.text, this.type, this.isShow, this.leftIcon);

  factory ContactsGroupItem.fromJson(Map<String, dynamic> json) {
    String? text = json['text'];
    String? type = json['type'];
    bool? isShow = json['isShow'];
    String? leftIcon = json['leftIcon'];
    return ContactsGroupItem(text, type, isShow, leftIcon);
  }

  String? text;
  String? type;
  bool? isShow;
  String? leftIcon;

  String get leftImage {
    String path = 'contacts/contacts_header';
    String groupType = type ?? '';
    switch (groupType) {
      case 'public_layout': {
        path = 'contacts/public_account';
        break;
      }
      case 'group_layout': {
        path = 'contacts/chat_group';
        break;
      }
      case 'org_layout' : {
        path = 'contacts/org_structure';
        break;
      }
      case 'new_friends_layout' : {
        path = 'contacts/new_friends';
        break;
      }
    }
    return path;
  }
}