import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_platform.dart';
import 'package:flutter_cloud_platform/base/dao/contacts_dao.dart';
import 'package:flutter_cloud_platform/base/dao/visual_dao.dart';
import 'package:flutter_cloud_platform/base/models/mcs_grouped_data_item.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_route.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_visual.dart';
import 'package:flutter_cloud_platform/base/network/contacts_api.dart';
import 'package:flutter_cloud_platform/contacts/models/contacts_category.dart';
import 'package:flutter_cloud_platform/contacts/models/contacts_group.dart';
import 'package:flutter_cloud_platform/contacts/models/contacts_group_item.dart';

class ContactsProvider extends ChangeNotifier {
  ContactsGroup? _contactsGroup;
  List<ContactsCategory>? _categories;
  List<ContactsCategoryItem>? _allContacts = [];
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

  bool isFriend(String userId) {
    bool result = false;
    _categories?.forEach((category) {
      if (category.type == ContactsCategoryType.friend.value) {
        category.items?.forEach((element) {
          if (element.username == userId) {
            result = true;
          }
        });
      }
    });
    return result;
  }

  String fetchNickname(String userId) {
    String? nickname;
    _categories?.forEach((category) {
      if (category.type == ContactsCategoryType.friend.value ||
          category.type == ContactsCategoryType.normal.value) {
        category.items?.forEach((element) {
          if (element.username == userId) {
            nickname = element.displayName;
          }
        });
      }
    });
    if (nickname == null) {
      updateContacts(userId);
    }
    return nickname ?? userId;
  }

  String fetchIconUrl(String userId) {
    String? iconUrl;
    _categories?.forEach((category) {
      if (category.type == ContactsCategoryType.friend.value ||
          category.type == ContactsCategoryType.normal.value) {
        category.items?.forEach((element) {
          if (element.username == userId) {
            iconUrl = element.headUrl;
          }
        });
      }
    });
    if (iconUrl == null) {
      updateContacts(userId);
    }
    return iconUrl ?? '';
  }

  void updateContacts(String userId, {bool updateNickname = false, bool updateHead = false}) async {
    if (!updateNickname && !updateHead) {
      return;
    }
    Response? response = await ContactsApi.singleton.fetchContactDetail(userId);
    ContactsDao dao = ContactsDao();
    ContactsCategoryItem item;
    if (response != null) {
      Map<String, dynamic> map = response.data as Map<String, dynamic>;
      item = ContactsCategoryItem.fromJson(map);
      item.type = isFriend(userId)? ContactsCategoryType.friend.value: ContactsCategoryType.normal.value;
      dao.saveContacts(item);
      _allContacts?.removeWhere((item) => item.username == userId);
      _allContacts?.add(item);
      _categories?.forEach((category) {
        if (category.type == item.type) {
          category.items?.removeWhere((item) => item.username == userId);
          category.items?.add(item);
        }
      });
      if ((updateNickname && (item.displayName?.isNotEmpty ?? false)) ||
          (updateHead && (item.headUrl?.isNotEmpty ?? false))) {
        notifyListeners();
      }
    }
  }

  Future<void> fetchContactList() async {
    VisualDao visualDao = VisualDao();
    MCSVisual? visual = await visualDao.fetchVisualWithId(GUID);
    MCSRoute? route = visual?.appConfig?.pages?.pageConfig?[contactsList1];
    Map<String, dynamic> map = json.decode(route?.content ?? '');
    _contactsGroup = ContactsGroup.fromJson(map);

    Response? response = await ContactsApi.singleton.fetchContactList();
    ContactsDao dao = ContactsDao();

    List<ContactsCategoryItem> publicContacts = [];
    List<ContactsCategoryItem> friends = [];

    ContactsCategory normalCategory = ContactsCategory(ContactsCategoryType.normal.value, 'normal', []);
    if (response != null) {
      List<dynamic>? list = response.data as List<dynamic>?;
      _categories = list?.map((e) {
        Map<String, dynamic> map = (e as Map<String, dynamic>?) ?? {};
        ContactsCategory contactsCategory = ContactsCategory.fromJson(map);
        contactsCategory.items?.forEach((item) {
          if (!(_allContacts?.contains(item) ?? false)) {
            _allContacts?.add(item);
          }
          dao.saveContacts(item, type: contactsCategory.type, tag: contactsCategory.tag);
        });
        return contactsCategory;
      }).toList();
      if (_categories?.isNotEmpty ?? false) {
        _categories?.add(normalCategory);
        notifyListeners();
      }
    } else {
      List<ContactsCategoryItem> contacts = await dao.fetchAllContacts();
      for (var item in contacts) {
        if (!(_allContacts?.contains(item) ?? false)) {
          _allContacts?.add(item);
        }
        if (item.type == ContactsCategoryType.publicAccount.value) {
          if (!(publicContacts.contains(item))) {
            publicContacts.add(item);
          }
        }
        if (item.type == ContactsCategoryType.friend.value) {
          if (!(friends.contains(item))) {
            friends.add(item);
          }
        }
      }
      ContactsCategory publicCategory = ContactsCategory(ContactsCategoryType.publicAccount.value, '公众账号', publicContacts);
      ContactsCategory friendCategory = ContactsCategory(ContactsCategoryType.friend.value, '我的好友', friends);
      _categories = [publicCategory, friendCategory, normalCategory];
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
        if (category.type == ContactsCategoryType.friend.value) {
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
        if (category.type == ContactsCategoryType.friend.value) {
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