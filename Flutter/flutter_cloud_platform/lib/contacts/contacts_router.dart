import 'package:fluro/fluro.dart';
import 'package:fluro/src/fluro_router.dart';
import 'package:flutter_cloud_platform/contacts/page/add_contacts_page.dart';
import 'package:flutter_cloud_platform/contacts/page/contacts_detail_page.dart';
import 'package:flutter_cloud_platform/contacts/page/contacts_page.dart';
import 'package:flutter_cloud_platform/contacts/page/group_page.dart';
import 'package:flutter_cloud_platform/contacts/page/organization_structure_page.dart';
import 'package:flutter_cloud_platform/contacts/page/public_account_page.dart';
import 'package:flutter_cloud_platform/contacts/page/select_contacts_page.dart';
import 'package:flutter_cloud_platform/routes/i_router.dart';

class ContactsRouter extends IRouterProvider {

  static const String contactsPage = "/contacts";
  static const String addContactsPage = "/contacts/addContacts";
  static const String selectContactsPage = "/contacts/selectContacts";
  static const String contactsDetailPage = "/contacts/detail";
  static const String publicAccountPage = "/contacts/publicAccount";
  static const String groupPage = "/contacts/groupPage";
  static const String orgStructurePage = "/contacts/orgStructure";

  @override
  void initRouter(FluroRouter router) {
    router.define(contactsPage, handler: Handler(handlerFunc: (_, __) => ContactsPage()));
    router.define(addContactsPage, handler: Handler(handlerFunc: (_, __) => AddContactsPage()));
    router.define(selectContactsPage, handler: Handler(handlerFunc: (_, __) => SelectContactsPage()));
    router.define(contactsDetailPage, handler: Handler(handlerFunc: (context, __) {
      final String? userId = context?.settings?.arguments as String?;
      return ContactsDetailPage(userId: userId,);
    }));
    router.define(publicAccountPage, handler: Handler(handlerFunc: (_, __) => PublicAccountPage()));
    router.define(groupPage, handler: Handler(handlerFunc: (_, __) => GroupPage()));
    router.define(orgStructurePage, handler: Handler(handlerFunc: (_, __) => OrganizationStructurePage()));
  }

}