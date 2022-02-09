import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/contacts/models/contacts_group.dart';

class ContactsProvider extends ChangeNotifier {
  ContactsProvider(String? content) {
    Map<String, dynamic> map = json.decode(content ?? '');
    _contactsGroup = ContactsGroup.fromJson(map);
  }

  ContactsGroup? _contactsGroup;

  Future<void> fetchContactList() async {

  }
}