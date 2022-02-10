import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/dao/contacts_dao.dart';
import 'package:flutter_cloud_platform/base/network/contacts_api.dart';
import 'package:flutter_cloud_platform/contacts/models/contacts_category.dart';
import 'package:flutter_cloud_platform/contacts/models/contacts_group.dart';

class ContactsProvider extends ChangeNotifier {
  ContactsProvider(String? content) {
    Map<String, dynamic> map = json.decode(content ?? '');
    _contactsGroup = ContactsGroup.fromJson(map);
  }

  ContactsGroup? _contactsGroup;
  List<ContactsCategory>? _categorys;

  Future<void> fetchContactList() async {
    Response? response = await ContactsApi.singleton.fetchContactList();
    if (response != null) {
      List<dynamic>? list = response.data as List<dynamic>?;
      ContactsDao dao = ContactsDao();
      _categorys = list?.map((e) {
        Map<String, dynamic> map = (e as Map<String, dynamic>?) ?? {};
        ContactsCategory contactsCategory = ContactsCategory.fromJson(map);
        contactsCategory.items?.forEach((item) {
          dao.saveContacts(item, type: contactsCategory.type, tag: contactsCategory.tag);
        });
        return contactsCategory;
      }).toList();
      if (_categorys != null) {
        notifyListeners();
      }
    }
  }
}