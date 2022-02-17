import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/models/mcs_grouped_data_item.dart';
import 'package:flutter_cloud_platform/base/models/platform_visual/mcs_route.dart';
import 'package:flutter_cloud_platform/base/providers/provider.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_asset_image.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_list_tile.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_title.dart';
import 'package:flutter_cloud_platform/contacts/contacts_router.dart';
import 'package:flutter_cloud_platform/contacts/models/contacts_category.dart';
import 'package:flutter_cloud_platform/contacts/models/contacts_group.dart';
import 'package:flutter_cloud_platform/contacts/models/contacts_group_item.dart';
import 'package:flutter_cloud_platform/contacts/providers/contacts_provider.dart';
import 'package:flutter_cloud_platform/routes/mcs_navigator.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContactsPage extends StatefulWidget {

  const ContactsPage({Key? key}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {

  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  ContactsProvider? _contactsProvider;
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      _contactsProvider?.search = _controller.text;
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    VisualProvider visualProvider = Provider.of<VisualProvider>(context, listen:false);
    String? addFriendType = visualProvider.fetchAddFriendType();
    bool showOrg = (visualProvider.fetchOrgUrl() ?? '').isNotEmpty;

    return Scaffold(
        appBar: AppBar(
          title: MCSTitle('联系人', type: MCSTitleType.barTitle,),
        ),
        body: SmartRefresher(
            onRefresh: () async {
              await _contactsProvider?.fetchContactList();
              _refreshController.refreshCompleted();
            },
            controller: _refreshController,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _buildSearchHeader(),
                ),
                Consumer<ContactsProvider>(builder: (_, contactsProvider, __) {
                  contactsProvider.fetchContactList();
                  List<MCSGroupedDataItem<ContactsGroupType, dynamic>> datasource = contactsProvider.fetchContactsListDataSource(addFriendType: addFriendType, showOrg: showOrg);
                  return _buildSliverList(datasource, contactsProvider);
                })
              ],
            )
        )
    );
  }

  Widget _buildSliverList(
      List<MCSGroupedDataItem<ContactsGroupType, dynamic>> datasource,
      ContactsProvider contactsProvider) {
    _contactsProvider = contactsProvider;
    return SliverList(
      delegate: SliverChildBuilderDelegate(
              (_, index) {
            String? iconUrl;
            String? placeholder;
            String? title;
            String? subTitle;
            String? userId;
            MCSGroupedDataItem item = datasource[index];
            switch (item.groupType) {
              case ContactsGroupType.other: {
                ContactsGroupItem? cgi = item.data as ContactsGroupItem?;
                if (cgi != null) {
                  placeholder = cgi.leftImage;
                  title = cgi.text;
                } else {
                  return MCSLayout.vGap0;
                }
                break;
              }
              case ContactsGroupType.friend: {
                ContactsCategoryItem? cci = item.data as ContactsCategoryItem?;
                if (cci != null) {
                  iconUrl = cci.headUrl;
                  title = cci.displayName;
                  subTitle = cci.username;
                  userId = cci.username;
                } else {
                  Widget header = _buildHeader(
                    ContactsGroupType.friend.value,
                    isFold: contactsProvider.isFold,
                    onTap: () {
                      contactsProvider.fold = !contactsProvider.isFold;
                      _focusNode.unfocus();
                    },
                  );
                  return header;
                }
                break;
              }
              default: {
                return MCSLayout.vGap0;
              }
            }

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MCSLayout.padding),
                  child: MCSListTile(
                    height: MCSLayout.listTileHeight,
                    iconUrl: iconUrl,
                    placeholder: placeholder,
                    title: title,
                    subTitle: subTitle,
                    titleType: MCSTitleType.listTitleNormal,
                    subtitleType: MCSTitleType.listSubTitleNormal,
                    onTap: () {
                      MCSNavigator.push(context, ContactsRouter.contactsDetailPage, parameter: userId);
                    },
                  ),
                ),
                Divider(
                  height: 1.0,
                  indent: MCSLayout.listIndent
                )
              ],
            );
          },
          childCount: datasource.length
      ),
    );
  }

  Widget _buildSearchHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MCSLayout.vPadding, horizontal: MCSLayout.padding),
      child: SizedBox(
        height: MCSLayout.listHeaderHeight,
        child: TextField(
          autofocus: _controller.text.isNotEmpty,
          focusNode: _focusNode,
          controller: _controller,
          decoration: const InputDecoration(
            labelText: '搜索',
          ),
        )
      ),
    );
  }

  Widget _buildHeader(String title, {bool isFold = true, void Function()? onTap}) {
    Widget header = GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: MCSLayout.listHeaderHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MCSLayout.padding),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MCSAssetImage(
                    isFold? 'contacts/arrow_fold': 'contacts/arrow_unfold',
                    width: 20.0,
                    height: 20.0,
                  ),
                  MCSLayout.hGap5,
                  Text(title)
                ],
              ),
            ),
            MCSLayout.vGap5,
            const Divider(height: 1.0),
          ],
        )
      ),
    );
    return header;
  }
}
