import 'dart:convert';
import 'package:assassin_flutter_module/channels/application_configuration_channel.dart';
import 'package:assassin_flutter_module/constants.dart';
import 'package:assassin_flutter_module/pages/share/models/disk_attachment.dart';
import 'package:assassin_flutter_module/pages/share/models/image_attachment.dart';
import 'package:assassin_flutter_module/pages/share/models/location_attachment.dart';
import 'package:assassin_flutter_module/pages/share/models/share_action_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_callbacks_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_comment.dart';
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
import 'package:assassin_flutter_module/pages/share/widgets/share_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

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
  ShareCallbacksProvider _callbacksProvider;
  FocusNode _focusNode = FocusNode();
  FocusScopeNode _focusScopeNode;
  ScrollController _scrollController = ScrollController();
  GlobalKey _activeKey;

  @override
  void initState() {
    // TODO: implement initState
    ApplicationConfigurationChannel.shared.fetchThemeColor().then((color) {
      setState(() {
        _themeColor = color;
      });
    });

    _callbacksProvider = ShareCallbacksProvider(
      giveLike: giveLike,
      cancelLike: cancelLike,
      onTapComment: onTapComment,
      retransmit: retransmit,
      switchContentDisplayState: switchContentDisplayState,
      onTapImageAttachment: onTapImageAttachment,
      onTapLocationAttachment: onTapLocationAttachment,
      onTapDiskAttachment: onTapDiskAttachment,
      onTapPhoneNumber: onTapPhoneNumber,
      onTapWebLink: onTapWebLink,
      onTapNickname: onTapNickname,
      deleteComment: deleteComment,
      saveToCloudDisk: saveToCloudDisk,
      collect: collect,
      copy: copy,
      delete: delete,
      onTapCommentItem: onTapCommentItem
    );

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
          int index = 0;
          for (ShareItem item in shares) {
            ShareHeaderProvider shareHeaderProvider = ShareHeaderProvider(index, item.headUrl, item.publisherName, item.publisher, item.publishTime);
            ShareContentProvider shareContentProvider = ShareContentProvider(index, item.content);
            shareHeaderProviderList.add(shareHeaderProvider);
            shareContentProviderList.add(shareContentProvider);
            ShareImageAttachmentProvider imageAttachmentProvider = null;
            ShareLocationAttachmentProvider locationAttachmentProvider = null;
            ShareFileAttachmentProvider fileAttachmentProvider = null;
            for (dynamic attachment in item.files) {
              if (attachment.runtimeType == ImageAttachment && (attachment as ImageAttachment).originalImagePath.length > 0) {
                imageAttachmentProvider = ShareImageAttachmentProvider(index, attachment);
              } else if(attachment.runtimeType == LocationAttachment) {
                locationAttachmentProvider = ShareLocationAttachmentProvider(index, attachment);
              } else if(attachment.runtimeType == DiskAttachment) {
                fileAttachmentProvider = ShareFileAttachmentProvider(index, attachment);
              }
            }
            shareImageAttachmentProviderList.add(imageAttachmentProvider);
            shareLocationAttachmentProviderList.add(locationAttachmentProvider);
            shareFileAttachmentProviderList.add(fileAttachmentProvider);
            ShareActionProvider shareActionProvider = ShareActionProvider(index, publisherId: item.publisher);
            ShareGoodsProvider goodsProvider = ShareGoodsProvider(index, goods: item.goods);
            ShareCommentsProvider commentsProvider = ShareCommentsProvider(index, comments: item.comments);
            shareActionProviderList.add(shareActionProvider);
            shareGoodsProviderList.add(goodsProvider);
            shareCommentsProviderList.add(commentsProvider);
            index++;
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

    // KeyboardVisibilityController visibilityController = KeyboardVisibilityController();
    // visibilityController.onChange.listen((bool visible) {
    //   print(visible);
    //   if (visible) {
    //     double keyboardHeight = 346.0;
    //     double textFieldMinY = MediaQuery.of(context).size.height - keyboardHeight - share_text_field_height;
    //
    //     RenderBox box = _activeKey.currentContext.findRenderObject();
    //     Offset offset = box.localToGlobal(Offset.zero);
    //     double boxMaxY = offset.dy + box.size.height;
    //
    //     double scrollOffset = _scrollController.offset;
    //
    //     double delta = boxMaxY - textFieldMinY + scrollOffset;
    //     if (delta > 0.0) {
    //       // _scrollController.animateTo(delta, duration: Duration(milliseconds: 250), curve: Curves.ease);
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("分享"),
        backgroundColor: _themeColor,
      ),
      body: SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            children: [
              Container(
                child: ListView.separated(
                    // controller: _scrollController,
                    itemBuilder: (context, index) {
                      ShareItem item = _shareList[index];
                      return GestureDetector(
                        child: Container(
                          color: Colors.white,
                          child: ShareCell(
                              item.id,
                              _shareHeaderProviderList[index],
                              _shareContentProviderList[index],
                              _shareImageAttachmentProviderList[index],
                              _shareLocationAttachmentProviderList[index],
                              _shareFileAttachmentProviderList[index],
                              _shareActionProviderList[index],
                              _shareGoodsProviderList[index],
                              _shareCommentsProviderList[index],
                              _callbacksProvider
                          ),
                        ),
                        onTap: () => onTapCell(index),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(height: divide_height, indent: divide_indent,);
                    },
                    itemCount: _shareList?.length ?? 0),
              ),
              Positioned(
                bottom: -MediaQuery.of(context).padding.bottom,
                child: ShareTextField(focusNode: _focusNode,),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapCell(int index) {

  }

  void giveLike(int index) {
    print("giveLike");
  }

  void cancelLike(int index) {
    print("cancelLike");
  }

  void publishComment(String content, int index) {
    print("publishComment");
  }

  void retransmit(int index) {
    print("retransmit");
  }

  void switchContentDisplayState(int index) {
    ShareContentProvider contentProvider = _shareContentProviderList[index];
    contentProvider.switchContentDisplayState();
  }

  void onTapImageAttachment(List urls, int index) {
    print("onTapImageAttachment");
  }

  void onTapLocationAttachment(int index) {
    print("onTapLocationAttachment");
  }

  void onTapDiskAttachment(int index) {
    print("onTapDiskAttachment");
  }

  void onTapPhoneNumber(String phoneNumber) {
    print("onTapPhoneNumber");
  }

  void onTapWebLink(String url) {
    print("onTapWebLink");
  }

  void onTapNickname(String userId) {
    print("onTapNickname");
  }

  void deleteComment(ShareComment comment, int index) {
    print("deleteComment");
  }

  void saveToCloudDisk(String url) {
    print("saveToCloudDisk");
  }

  void collect(dynamic value, int index) {
    print("collect");
  }

  void copy(String text) {
    print("copy");
  }

  void delete(int index) {
    print("delete");
  }

  void onTapComment(int index, GlobalKey key) {
    _activeKey = key;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          if (null == _focusScopeNode) {
            _focusScopeNode = FocusScope.of(context);
          }
          _focusScopeNode.requestFocus(_focusNode);
          return Container(
            height: 0,
          );
        }
    );
  }

  void onTapCommentItem(int index, GlobalKey key) {
    _activeKey = key;
    if (null == _focusScopeNode) {
      _focusScopeNode = FocusScope.of(context);
    }
    _focusScopeNode.requestFocus(_focusNode);
  }
}
