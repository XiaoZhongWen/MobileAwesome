import 'package:fluro/fluro.dart';
import 'package:fluro/src/fluro_router.dart';
import 'package:flutter_cloud_platform/contacts/page/add_contacts_page.dart';
import 'package:flutter_cloud_platform/contacts/page/contacts_page.dart';
import 'package:flutter_cloud_platform/contacts/page/select_contacts_page.dart';
import 'package:flutter_cloud_platform/routes/i_router.dart';
import 'package:flutter/material.dart';

class ContactsRouter extends IRouterProvider {

  static const String contactsPage = "/contacts";
  static const String addContactsPage = "/contacts/addContacts";
  static const String selectContactsPage = "/contacts/selectContacts";

  @override
  void initRouter(FluroRouter router) {
    router.define(contactsPage, handler: Handler(handlerFunc: (_, __) => ContactsPage()));
    router.define(addContactsPage, handler: Handler(handlerFunc: (_, __) => AddContactsPage()));
    router.define(selectContactsPage, handler: Handler(handlerFunc: (_, __) => SelectContactsPage()));
  }

}