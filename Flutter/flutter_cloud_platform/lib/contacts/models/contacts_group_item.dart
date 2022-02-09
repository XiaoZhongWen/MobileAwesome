class ContactsGroupItem {

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
}