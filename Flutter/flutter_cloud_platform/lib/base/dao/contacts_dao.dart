import 'dart:convert';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/db/mcs_db_service.dart';
import 'package:flutter_cloud_platform/contacts/models/contacts_category.dart';

enum ContactsCategoryType {
  publicAccount,
  friend
}

extension on ContactsCategoryType {
  int get value => [1, 3][index];
}

class ContactsDao {
  /*
  * 保存联系人
  * type=0 普通联系人
  * type=1 公众账号
  * type=3 我的好友
  * */
  void saveContacts(ContactsCategoryItem item, {int? type, String? tag}) async {
    String username = item.username ?? '';
    if (username.isEmpty) {
      return;
    }
    Map<String, dynamic> map = {
      'tag':tag,
      'username':item.username,
      'displayName':item.displayName,
      'headUrl':item.headUrl,
      'workStatus':json.encode(item.workStatus?.toJson()),
      'card':json.encode(item.card),
    };
    List list = await MCSDBService.singleton.query(contactsTableName, where: 'username = ?', whereArgs: [username]);
    if (list.isEmpty) {
      if (type == null) {
        map['type'] = 0;
      }
      MCSDBService.singleton.insert(contactsTableName, map);
    } else {
      MCSDBService.singleton.update(contactsTableName, map, where: 'username = ?', whereArgs: [username]);
    }
  }

  Future<List<ContactsCategoryItem>> fetchContactsCategory(ContactsCategoryType type) async {
    List list = await MCSDBService.singleton.query(contactsTableName, where: 'type = ?', whereArgs: [type.value]);
    if (list.isEmpty) {
      return [];
    } else {
      List<ContactsCategoryItem> contacts = list.map((e) {
        String? username = e['username'];
        String? displayName = e['displayName'];
        String? headUrl = e['headUrl'];
        Map<String, dynamic>? workStatus = json.decode(e['workStatus']);
        Map<String, dynamic>? card = json.decode(e['card']);
        Map<String, dynamic> m = {
          'username':username,
          'displayName':displayName,
          'headUrl':headUrl,
          'workStatus':workStatus,
          'card':card
        };
        return ContactsCategoryItem.fromJson(m);
      }).toList();
      return contacts;
    }
  }

  Future<ContactsCategoryItem?> fetchContacts(String userId) async {
    List list = await MCSDBService.singleton.query(contactsTableName, where: 'username = ?', whereArgs: [userId]);
    return list.first;
  }

  void deleteContact(String username) {
    MCSDBService.singleton.delete(contactsTableName, where: 'username = ?', whereArgs: [username]);
  }

  void updateContact(ContactsCategoryItem item, {ContactsCategoryType? type}) {
    String username = item.username ?? '';
    if (username.isEmpty) {
      return;
    }
    Map<String, dynamic> map = {
      'type':type?.value,
      'username':item.username,
      'displayName':item.displayName,
      'headUrl':item.headUrl,
      'workStatus':json.encode(item.workStatus?.toJson())
    };
    MCSDBService.singleton.update(contactsTableName, map, where: 'username = ?', whereArgs: [username]);
  }
}