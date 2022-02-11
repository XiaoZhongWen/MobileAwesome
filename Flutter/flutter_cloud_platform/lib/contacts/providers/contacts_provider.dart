import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/dao/contacts_dao.dart';
import 'package:flutter_cloud_platform/base/models/mcs_grouped_data_item.dart';
import 'package:flutter_cloud_platform/base/network/contacts_api.dart';
import 'package:flutter_cloud_platform/contacts/models/contacts_category.dart';
import 'package:flutter_cloud_platform/contacts/models/contacts_group.dart';
import 'package:flutter_cloud_platform/contacts/models/contacts_group_item.dart';

class ContactsProvider extends ChangeNotifier {
  ContactsProvider(String? content) {
    Map<String, dynamic> map = json.decode(content ?? '');
    _contactsGroup = ContactsGroup.fromJson(map);
    fetchContactList();
  }

  ContactsGroup? _contactsGroup;
  List<ContactsCategory>? _categories;

  Future<void> fetchContactList() async {
    Response? response = await ContactsApi.singleton.fetchContactList();
    ContactsDao dao = ContactsDao();

    if (response != null) {
      List<dynamic>? list = response.data as List<dynamic>?;
      _categories = list?.map((e) {
        Map<String, dynamic> map = (e as Map<String, dynamic>?) ?? {};
        ContactsCategory contactsCategory = ContactsCategory.fromJson(map);
        contactsCategory.items?.forEach((item) {
          dao.saveContacts(item, type: contactsCategory.type, tag: contactsCategory.tag);
        });
        return contactsCategory;
      }).toList();
      if (_categories?.isNotEmpty ?? false) {
        notifyListeners();
      }
    } else {
      List<ContactsCategoryItem> publicContacts = await dao.fetchContactsCategory(ContactsCategoryType.publicAccount);
      List<ContactsCategoryItem> friends = await dao.fetchContactsCategory(ContactsCategoryType.friend);
      ContactsCategory publicCategory = ContactsCategory(1, '公众账号', publicContacts);
      ContactsCategory friendCategory = ContactsCategory(3, '我的好友', friends);
      _categories = [publicCategory, friendCategory];
      if (_categories?.isNotEmpty ?? false) {
        notifyListeners();
      }
    }
  }

  /*
  * 获取联系人列表数据源
  * addFriendType:DEFAULT 表示添加好友时不需要对方确认
  * addFriendType:CONFIRM 表示添加好友时需要对方确认
  * */
  List<MCSGroupedDataItem> fetchContactsListDataSource({String? addFriendType, bool showOrg = false}) {
    List<MCSGroupedDataItem> list = [];
    String groupA = '';
    String groupB = '我的好友';
    if (addFriendType != null && addFriendType == 'CONFIRM') {
      list.add(MCSGroupedDataItem(groupA, ContactsGroupItem('新的好友', 'new_friends_layout', true, '')));
    }

    _contactsGroup?.content?.forEach((element) {
      if ((element.isShow ?? false)) {
        if (!(element.type == 'org_layout' && !showOrg)) {
          list.add(MCSGroupedDataItem(groupA, element));
        }
      }
    });

    _categories?.forEach((category) {
      if (category.type == 3) {
        category.items?.forEach((element) {
          list.add(MCSGroupedDataItem(groupB, element));
        });
      }
    });

    return list;
  }
}