import 'dart:convert';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/db/mcs_db_service.dart';
import 'package:flutter_cloud_platform/contacts/models/contacts_category.dart';

class ContactsDao {
  void saveContacts(ContactsCategoryItem item, {int? type, String? tag}) async {
    String username = item.username ?? '';
    if (username.isEmpty) {
      return;
    }
    Map<String, dynamic> map = {
      'type':type,
      'tag':tag,
      'username':item.username,
      'displayName':item.displayName,
      'headUrl':item.headUrl,
      'workStatus':json.encode(item.workStatus?.toJson())
    };
    List list = await MCSDBService.singleton.query(contactsTableName, where: 'username = ', whereArgs: [username]);
    if (list.isEmpty) {
      MCSDBService.singleton.insert(contactsTableName, map);
    } else {
      MCSDBService.singleton.update(contactsTableName, map, where: 'username = ', whereArgs: [username]);
    }
  }

  Future<List<ContactsCategoryItem>> fetchContactsCategory(int type) async {
    List list = await MCSDBService.singleton.query(contactsTableName, where: 'type = ', whereArgs: [type]);
    if (list.isEmpty) {
      return [];
    } else {
      List<ContactsCategoryItem> contacts = list.map((e) {
        String? username = e['username'];
        String? displayName = e['displayName'];
        String? headUrl = e['headUrl'];
        Map<String, dynamic>? workStatus = json.decode(e['workStatus']);
        Map<String, dynamic> m = {
          'username':username,
          'displayName':displayName,
          'headUrl':headUrl,
          'workStatus':workStatus,
        };
        return ContactsCategoryItem.fromJson(m);
      }).toList();
      return contacts;
    }
  }

  void deleteContact(String username) {
    MCSDBService.singleton.delete(contactsTableName, where: 'username = ', whereArgs: [username]);
  }

  void updateContact(ContactsCategoryItem item, {int? type}) {
    String username = item.username ?? '';
    if (username.isEmpty) {
      return;
    }
    Map<String, dynamic> map = {
      'type':type,
      'username':item.username,
      'displayName':item.displayName,
      'headUrl':item.headUrl,
      'workStatus':json.encode(item.workStatus?.toJson())
    };
    MCSDBService.singleton.update(contactsTableName, map, where: 'username = ', whereArgs: [username]);
  }
}