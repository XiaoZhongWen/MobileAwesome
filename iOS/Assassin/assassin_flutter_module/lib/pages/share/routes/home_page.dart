import 'dart:convert';
import 'package:assassin_flutter_module/channels/application_configuration_channel.dart';
import 'package:assassin_flutter_module/constants.dart';
import 'package:assassin_flutter_module/pages/share/models/disk_attachment.dart';
import 'package:assassin_flutter_module/pages/share/models/image_attachment.dart';
import 'package:assassin_flutter_module/pages/share/models/location_attachment.dart';
import 'package:assassin_flutter_module/pages/share/models/share_action_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_comments_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_content_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_file_attachment_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_goods_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_header_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_image_attachment_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_item.dart';
import 'package:assassin_flutter_module/pages/share/models/share_location_attachment_provider.dart';
import 'package:assassin_flutter_module/pages/share/services/share_service.dart';
import 'package:assassin_flutter_module/pages/share/widgets/share_cell.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _themeColor = Colors.blue;
  List<ShareItem> _shareList;
  List<ShareHeaderProvider> _shareHeaderProviderList = [];
  List<ShareContentProvider> _shareContentProviderList = [];
  List<ShareImageAttachmentProvider> _shareImageAttachmentProviderList = [];
  List<ShareLocationAttachmentProvider> _shareLocationAttachmentProviderList = [];
  List<ShareFileAttachmentProvider> _shareFileAttachmentProviderList = [];
  List<ShareActionProvider> _shareActionProviderList = [];
  List<ShareGoodsProvider> _shareGoodsProviderList = [];
  List<ShareCommentsProvider> _shareCommentsProviderList = [];

  @override
  void initState() {
    // TODO: implement initState
    ApplicationConfigurationChannel.shared.fetchThemeColor().then((color) {
      setState(() {
        _themeColor = color;
      });
    });

    ShareService.shared.fetchShares(0)
        .then((shares) {
          List<ShareHeaderProvider> shareHeaderProviderList = [];
          List<ShareContentProvider> shareContentProviderList = [];
          List<ShareImageAttachmentProvider> shareImageAttachmentProviderList = [];
          List<ShareLocationAttachmentProvider> shareLocationAttachmentProviderList = [];
          List<ShareFileAttachmentProvider> shareFileAttachmentProviderList = [];
          List<ShareActionProvider> shareActionProviderList = [];
          List<ShareGoodsProvider> shareGoodsProviderList = [];
          List<ShareCommentsProvider> shareCommentsProviderList = [];
          for (ShareItem item in shares) {
            ShareHeaderProvider shareHeaderProvider = ShareHeaderProvider(item.headUrl, item.publisherName, item.publisher, item.publishTime);
            ShareContentProvider shareContentProvider = ShareContentProvider(item.content);
            shareHeaderProviderList.add(shareHeaderProvider);
            shareContentProviderList.add(shareContentProvider);
            ShareImageAttachmentProvider imageAttachmentProvider = null;
            ShareLocationAttachmentProvider locationAttachmentProvider = null;
            ShareFileAttachmentProvider fileAttachmentProvider = null;
            for (dynamic attachment in item.files) {
              if (attachment.runtimeType == ImageAttachment && (attachment as ImageAttachment).originalImagePath.length > 0) {
                imageAttachmentProvider = ShareImageAttachmentProvider(attachment);
              } else if(attachment.runtimeType == LocationAttachment) {
                locationAttachmentProvider = ShareLocationAttachmentProvider(attachment);
              } else if(attachment.runtimeType == DiskAttachment) {
                fileAttachmentProvider = ShareFileAttachmentProvider(attachment);
              }
            }
            shareImageAttachmentProviderList.add(imageAttachmentProvider);
            shareLocationAttachmentProviderList.add(locationAttachmentProvider);
            shareFileAttachmentProviderList.add(fileAttachmentProvider);
            ShareActionProvider shareActionProvider = ShareActionProvider(publisherId: item.publisher);
            ShareGoodsProvider goodsProvider = ShareGoodsProvider(goods: item.goods);
            ShareCommentsProvider commentsProvider = ShareCommentsProvider(comments: item.comments);
            shareActionProviderList.add(shareActionProvider);
            shareGoodsProviderList.add(goodsProvider);
            shareCommentsProviderList.add(commentsProvider);
          }
          setState(() {
            _shareList = shares;
            _shareHeaderProviderList = shareHeaderProviderList;
            _shareContentProviderList = shareContentProviderList;
            _shareImageAttachmentProviderList = shareImageAttachmentProviderList;
            _shareLocationAttachmentProviderList = shareLocationAttachmentProviderList;
            _shareFileAttachmentProviderList = shareFileAttachmentProviderList;
            _shareActionProviderList = shareActionProviderList;
            _shareGoodsProviderList = shareGoodsProviderList;
            _shareCommentsProviderList = shareCommentsProviderList;
          });
    })
        .catchError((e) {
          print(e);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("分享"),
        backgroundColor: _themeColor,
      ),
      body: Container(
        child: ListView.separated(
            itemBuilder: (context, index) {
              ShareItem item = _shareList[index];
              return ShareCell(
                  item.id,
                  _shareHeaderProviderList[index],
                  _shareContentProviderList[index],
                  _shareImageAttachmentProviderList[index],
                  _shareLocationAttachmentProviderList[index],
                  _shareFileAttachmentProviderList[index],
                  _shareActionProviderList[index],
                  _shareGoodsProviderList[index],
                  _shareCommentsProviderList[index]
              );
            },
            separatorBuilder: (context, index) {
              return Divider(height: divide_height, indent: divide_indent,);
            },
            itemCount: _shareList?.length ?? 0),
      ),
    );
  }
}
