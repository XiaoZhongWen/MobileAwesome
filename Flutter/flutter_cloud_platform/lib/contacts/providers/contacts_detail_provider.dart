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

  Future<void> _init() async {
    Response? response = await ContactsApi.singleton.fetchContactDetail(userId ?? '');
    if (response != null) {
      Map<String, dynamic> map = response.data as Map<String, dynamic>;
      ContactsCategoryItem item = ContactsCategoryItem.fromJson(map);
      ContactsDao dao = ContactsDao();
      dao.saveContacts(item);
    }
  }
}