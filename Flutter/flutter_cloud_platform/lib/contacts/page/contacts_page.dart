import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_route.dart';
import 'package:flutter_cloud_platform/base/providers/provider.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_title.dart';
import 'package:flutter_cloud_platform/contacts/models/contacts_group.dart';
import 'package:flutter_cloud_platform/contacts/providers/contacts_provider.dart';
import 'package:provider/provider.dart';

class ContactsPage extends StatefulWidget {

  ContactsPage({Key? key}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    VisualProvider visualProvider = Provider.of<VisualProvider>(context, listen:false);
    MCSRoute? route = visualProvider.fetchRoute(contactsList1);

    return FutureProvider.value(
      value: _buildContactsProvider(route?.content),
      initialData: ContactsProvider(route?.content),
      child: Scaffold(
        appBar: AppBar(
          title: const MCSTitle('联系人'),
        ),
        body: Container(),
      ),
    );
  }

  Future<ContactsProvider> _buildContactsProvider(String? content) async {
    ContactsProvider contactsProvider = ContactsProvider(content);
    await contactsProvider.fetchContactList();
    return contactsProvider;
  }
}
