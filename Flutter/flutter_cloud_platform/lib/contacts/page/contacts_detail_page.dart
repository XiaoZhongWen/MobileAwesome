import 'package:flutter/material.dart';
import 'package:flutter_cloud_platform/base/constant/mcs_constant.dart';
import 'package:flutter_cloud_platform/base/providers/provider.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_list_tile.dart';
import 'package:flutter_cloud_platform/base/widgets/mcs_title.dart';
import 'package:flutter_cloud_platform/contacts/models/contacts_category.dart';
import 'package:flutter_cloud_platform/contacts/providers/contacts_detail_provider.dart';
import 'package:flutter_cloud_platform/contacts/providers/contacts_provider.dart';
import 'package:flutter_cloud_platform/conversation/conversation_router.dart';
import 'package:flutter_cloud_platform/routes/mcs_navigator.dart';
import 'package:provider/provider.dart';

enum EventType {
  call,
  message,
  addFriend,
  deleteFriend
}

extension on EventType {
  String get value => ['打电话', '发消息', '添加好友', '删除好友'][index];
}

const double bottomHeight = 100;

class ContactsDetailPage extends StatefulWidget {
  ContactsDetailPage({Key? key, this.userId}) : super(key: key);

  final String? userId;

  @override
  _ContactsDetailPageState createState() => _ContactsDetailPageState();
}

class _ContactsDetailPageState extends State<ContactsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MCSTitle('详细资料', type: MCSTitleType.barTitle,),
      ),
      body: ChangeNotifierProvider.value(
        value: ContactsDetailProvider(widget.userId),
        child: Consumer<ContactsDetailProvider>(
          builder: (_, contactsDetailProvider, __) {
            ContactsCategoryItem? detail = contactsDetailProvider.contactDetail;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeader(detail),
                _buildFooter()
              ],
            );
          },
        )
      ),
    );
  }

  Widget _buildHeader(ContactsCategoryItem? detail) {
    Map<String, dynamic>? card = detail?.card;
    List<Widget> children = [
      MCSListTile(
        height: MCSLayout.listHeaderHeight,
        showIcon: false,
        title: '个人空间',
        titleType: MCSTitleType.listTitleSmall,
        trialing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: MCSLayout.arrowSize,),
      ),
      const Divider(height: 1.0,)
    ];

    String workStatus = detail?.workStatus?.workStatus ?? '';

    card?.forEach((key, value) {
      MCSListTile tile = MCSListTile(
        height: MCSLayout.listHeaderHeight,
        showIcon: false,
        title: key,
        titleType: MCSTitleType.listTitleSmall,
        subtitleType: MCSTitleType.listSubTitleSmall,
        trialing: MCSTitle(value, type: MCSTitleType.listSubTitleSmall,),
      );
      children.add(tile);
      children.add(const Divider(height: 1.0,));
    });
    return Column(
      children: [
        Card(
          margin: EdgeInsets.all(MCSLayout.margin),
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.only(
                left: MCSLayout.padding,
                right: MCSLayout.padding,
                bottom: MCSLayout.padding
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MCSListTile(
                  iconUrl: detail?.headUrl,
                  title: detail?.displayName,
                  subTitle: detail?.username,
                  titleType: MCSTitleType.cardTitle,
                  subtitleType: MCSTitleType.cardSubTitle,
                  height: MCSLayout.cardSize,
                  gap: MCSLayout.padding,
                ),
                workStatus.isEmpty?
                  MCSLayout.vGap0:
                  Padding(
                    padding: EdgeInsets.only(left: (MCSLayout.cardSize * 4 / 5 + MCSLayout.margin)),
                    child: MCSTitle(workStatus, type: MCSTitleType.listSubTitleSmall,),
                  )
              ],
            ),
          )
        ),
        (children.isNotEmpty)?
            Padding(
              padding: EdgeInsets.symmetric(horizontal: MCSLayout.padding),
              child: Column(children: children),
            ): MCSLayout.vGap0
      ],
    );
  }

  Widget _buildFooter() {
    VisualProvider visualProvider = Provider.of<VisualProvider>(context, listen: false);
    ContactsProvider contactsProvider = Provider.of<ContactsProvider>(context, listen: false);
    String? type = visualProvider.fetchAddFriendType();
    bool isFriend = contactsProvider.isFriend(widget.userId ?? '');

    List<ElevatedButton> children = [];
    if (type == 'CONFIRM' && !isFriend) {
      children = [
        ElevatedButton(
          onPressed: () {
            onEvent(EventType.addFriend);
          },
          child: Text(EventType.addFriend.value),
        )
      ];
    } else {
      MaterialStateProperty<Size> fixedSize = MaterialStateProperty.all(const Size(90, 40));
      List<EventType> events = [
        EventType.message,
        EventType.call,
        isFriend? EventType.deleteFriend: EventType.addFriend];
      children = events.map((e) {
        ButtonStyle style = ButtonStyle(fixedSize: fixedSize);
        if (e == EventType.deleteFriend || e == EventType.addFriend) {
          style = ButtonStyle(
              fixedSize: fixedSize,
              backgroundColor: MaterialStateProperty.all(Colors.white),
              foregroundColor: MaterialStateProperty.all(MCSColors.mainColor),
              shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    side: const BorderSide(width: 1.0, color: MCSColors.mainColor),
                    borderRadius: roundBorderRadius
                  )
              )
          );
        }
        return ElevatedButton(
          onPressed: () {
            onEvent(e);
          },
          child: Text(e.value),
          style: style,
        );
      }).toList();
    }

    return Container(
      height: bottomHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: children,
      ),
      // color: Colors.yellow,
    );
  }

  void onEvent(EventType type) {
    switch (type) {
      case EventType.message: {
        MCSNavigator.push(context, ConversationRouter.chatPage, parameter: widget.userId);
        break;
      }
      case EventType.call: {
        break;
      }
      case EventType.deleteFriend: {
        break;
      }
      case EventType.addFriend: {
        break;
      }
    }
  }
}
