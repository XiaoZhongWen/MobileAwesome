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
  bool isFold = true;
  String? searchKey;

  set fold(bool value) {
    isFold = value;
    notifyListeners();
  }

  set search(String key) {
    searchKey = key;
    notifyListeners();
  }

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
  List<MCSGroupedDataItem<ContactsGroupType, dynamic>> fetchContactsListDataSource({String? addFriendType, bool showOrg = false}) {
    List<MCSGroupedDataItem<ContactsGroupType, dynamic>> list = [];

    if (searchKey != null && searchKey!.isNotEmpty) {
      _categories?.forEach((category) {
        if (category.type == 3) {
          category.items?.forEach((element) {
            String username = element.username ?? '';
            if (username.contains(searchKey!)) {
              list.add(MCSGroupedDataItem<ContactsGroupType, ContactsCategoryItem>(
                  ContactsGroupType.friend, element)
              );
            }
          });
        }
      });
      list.add(MCSGroupedDataItem<ContactsGroupType, ContactsCategoryItem?>(
          ContactsGroupType.other, null)
      );
      return list;
    }

    if (addFriendType != null && addFriendType == 'CONFIRM') {
      list.add(
          MCSGroupedDataItem<ContactsGroupType, ContactsGroupItem>(
              ContactsGroupType.other, ContactsGroupItem('新的好友', 'new_friends_layout', true, '')
          )
      );
    }

    _contactsGroup?.content?.forEach((element) {
      if ((element.isShow ?? false)) {
        if (!(element.type == 'org_layout' && !showOrg)) {
          list.add(MCSGroupedDataItem<ContactsGroupType, ContactsGroupItem>(
              ContactsGroupType.other, element)
          );
        }
      }
    });

    list.add(MCSGroupedDataItem<ContactsGroupType, ContactsCategoryItem?>(
        ContactsGroupType.friend, null)
    );

    if (!isFold) {
      _categories?.forEach((category) {
        if (category.type == 3) {
          category.items?.forEach((element) {
            list.add(MCSGroupedDataItem<ContactsGroupType, ContactsCategoryItem>(
                ContactsGroupType.friend, element)
            );
          });
        }
      });
    }

    return list;
  }
}