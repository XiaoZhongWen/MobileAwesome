class WorkStatus {

  WorkStatus(this.id, this.workStatus, this.expireTime);

  factory WorkStatus.fromJson(Map<String, dynamic> map) {
    String? id = map['id'] as String?;
    String? workStatus = map['workStatus'] as String?;
    String? expireTime = map['expireTime'] as String?;
    return WorkStatus(id, workStatus, expireTime);
  }

  Map<String, dynamic> toJson() => {
    'id':id,
    'workStatus':workStatus,
    'expireTime':expireTime
  };

  String? id;
  String? workStatus;
  String? expireTime;
}

class ContactsCategoryItem {

  ContactsCategoryItem(this.username, this.displayName, this.headUrl, this.workStatus);

  factory ContactsCategoryItem.fromJson(Map<String, dynamic> map) {
    String? username = map['username'] as String?;
    String? displayName = map['displayName'] as String?;
    String? headUrl = map['headUrl'] as String?;
    WorkStatus? workStatus;
    Map<String, dynamic>? json = map['workStatus'] as Map<String, dynamic>?;
    if (json != null) {
      workStatus = WorkStatus.fromJson(json);
    }
    return ContactsCategoryItem(username, displayName, headUrl, workStatus);
  }

  String? username;
  String? displayName;
  String? headUrl;
  WorkStatus? workStatus;
}

class ContactsCategory {

  ContactsCategory(this.type, this.tag, this.items);

  factory ContactsCategory.fromJson(Map<String, dynamic> map) {
    int? type = map['type'] as int?;
    String? tag = map['tag'] as String?;
    List? list = map['items'] as List?;
    List<ContactsCategoryItem>? items = list?.map((e) {
      Map<String, dynamic>? json = e as Map<String, dynamic>?;
      return ContactsCategoryItem.fromJson(json ?? {});
    }).toList();

    return ContactsCategory(type, tag, items);
  }

  int? type;
  String? tag;
  List<ContactsCategoryItem>? items;
}