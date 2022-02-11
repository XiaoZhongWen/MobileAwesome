import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/models/mcs_grouped_data_item.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_route.dart';
import 'package:flutter_cloud_platform/base/providers/provider.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_listtile.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_title.dart';
import 'package:flutter_cloud_platform/contacts/models/contacts_category.dart';
import 'package:flutter_cloud_platform/contacts/models/contacts_group_item.dart';
import 'package:flutter_cloud_platform/contacts/providers/contacts_provider.dart';
import 'package:grouped_list/grouped_list.dart';
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
    String? addFriendType = visualProvider.fetchAddFriendType();
    bool showOrg = (visualProvider.fetchOrgUrl() ?? '').isNotEmpty;
    return ChangeNotifierProvider.value(
      value: ContactsProvider(route?.content),
      child: Scaffold(
        appBar: AppBar(
          title: const MCSTitle('联系人'),
        ),
        body: Consumer<ContactsProvider>(builder: (_, contactsProvider, __) {
          List<MCSGroupedDataItem> datasource = contactsProvider.fetchContactsListDataSource(addFriendType: addFriendType, showOrg: showOrg);
          return GroupedListView<MCSGroupedDataItem, String>(
            elements: datasource,
            groupBy: (e) => e.groupName,
            useStickyGroupSeparators: true,
            groupSeparatorBuilder: (groupName) {
              if (groupName.isEmpty) {
                return MCSLayout.gap0;
              } else {
                return Text(groupName);
              }
            },
            itemBuilder: (BuildContext context, MCSGroupedDataItem item) {
              String? iconUrl;
              String? placeholder;
              String? title;
              String? subTitle;
              if (item.groupName.isEmpty) {
                ContactsGroupItem? cgi = item.data as ContactsGroupItem?;
                placeholder = cgi?.leftImage;
                title = cgi?.text;
              } else {
                ContactsCategoryItem? cci = item.data as ContactsCategoryItem?;
                iconUrl = cci?.headUrl ?? '';
                title = cci?.displayName;
                subTitle = cci?.username;
              }
              return MCSListTile(
                height: 40,
                iconUrl: iconUrl,
                placeholder: placeholder,
                title: title,
                subTitle: subTitle,
              );
            },
          );
        }),
      ),
    );
  }
}
