import 'package:fluro/fluro.dart';
import 'package:fluro/src/fluro_router.dart';
import 'package:flutter_cloud_platform/routes/i_router.dart';
import 'package:flutter/material.dart';

class ContactsRouter extends IRouterProvider {

  final String _contactsPage = "/contacts";
  final String _addContactsPage = "/contacts/addContacts";
  final String _selectContactsPage = "/contacts/selectContacts";

  @override
  void initRouter(FluroRouter router) {
    router.define(_contactsPage, handler: Handler(handlerFunc: (_, __) => Text('')));
    router.define(_addContactsPage, handler: Handler(handlerFunc: (_, __) => Text('')));
    router.define(_selectContactsPage, handler: Handler(handlerFunc: (_, __) => Text('')));
  }

}