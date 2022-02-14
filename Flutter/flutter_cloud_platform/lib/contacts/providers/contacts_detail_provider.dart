import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/dao/contacts_dao.dart';
import 'package:flutter_cloud_platform/base/network/contacts_api.dart';
import 'package:flutter_cloud_platform/contacts/models/contacts_category.dart';

class ContactsDetailProvider extends ChangeNotifier {

  ContactsDetailProvider(this.userId) {
    _init();
  }

  String? userId;
  ContactsCategoryItem? contactDetail;

  void updateContactDetail(ContactsCategoryItem item) {
    contactDetail = item;
    notifyListeners();
  }

  Future<void> _init() async {
    if (userId == null) {
      return;
    }
    Response? response = await ContactsApi.singleton.fetchContactDetail(userId!);
    ContactsDao dao = ContactsDao();
    ContactsCategoryItem? item;
    if (response != null) {
      Map<String, dynamic> map = response.data as Map<String, dynamic>;
      item = ContactsCategoryItem.fromJson(map);
      dao.saveContacts(item);
    } else {
      item = await dao.fetchContacts(userId!);
    }
    if (item != null) {
      updateContactDetail(item);
    }
  }
}