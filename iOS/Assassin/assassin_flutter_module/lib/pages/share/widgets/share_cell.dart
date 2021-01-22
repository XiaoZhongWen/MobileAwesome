import 'package:assassin_flutter_module/constants.dart';
import 'package:assassin_flutter_module/pages/share/models/share_action_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_callbacks_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_comments_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_content_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_file_attachment_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_goods_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_header_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_image_attachment_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_location_attachment_provider.dart';
import 'package:assassin_flutter_module/pages/share/widgets/share_cell_action.dart';
import 'package:assassin_flutter_module/pages/share/widgets/share_cell_content.dart';
import 'package:assassin_flutter_module/pages/share/widgets/share_cell_file_attachment.dart';
import 'package:assassin_flutter_module/pages/share/widgets/share_cell_header.dart';
import 'package:assassin_flutter_module/pages/share/widgets/share_cell_image_container.dart';
import 'package:assassin_flutter_module/pages/share/widgets/share_cell_like_comment_container.dart';
import 'package:assassin_flutter_module/pages/share/widgets/share_cell_location.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ShareCell extends StatefulWidget {
  ShareHeaderProvider _headerProvider;
  ShareContentProvider _contentProvider;
  ShareImageAttachmentProvider _imageAttachmentProvider;
  ShareLocationAttachmentProvider _locationAttachmentProvider;
  ShareFileAttachmentProvider _fileAttachmentProvider;
  ShareActionProvider _shareActionProvider;
  ShareGoodsProvider _shareGoodsProvider;
  ShareCommentsProvider _commentsProvider;
  ShareCallbacksProvider _callbacksProvider;

  ShareCell(
      String id,
      this._headerProvider,
      this._contentProvider,
      this._imageAttachmentProvider,
      this._locationAttachmentProvider,
      this._fileAttachmentProvider,
      this._shareActionProvider,
      this._shareGoodsProvider,
      this._commentsProvider,
      this._callbacksProvider
      ): super(key: ValueKey(id));

  @override
  _ShareCellState createState() => _ShareCellState();
}

class _ShareCellState extends State<ShareCell> {
  Key _key;
  @override
  void initState() {
    // TODO: implement initState
    _key = GlobalKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: widget._headerProvider),
        ChangeNotifierProvider.value(value: widget._contentProvider),
        Provider.value(value: widget._imageAttachmentProvider),
        Provider.value(value: widget._locationAttachmentProvider),
        Provider.value(value: widget._fileAttachmentProvider),
        Provider.value(value: widget._shareActionProvider),
        ChangeNotifierProvider.value(value: widget._shareGoodsProvider),
        ChangeNotifierProvider.value(value: widget._commentsProvider,),
        Provider.value(value: widget._callbacksProvider),
        Provider.value(value: _key)
      ],
      child: Container(
        margin: EdgeInsets.all(default_margin),
        child: Column(
          children: [
            ShareCellHeader(),
            ShareCellContent(),
            widget._imageAttachmentProvider != null? ShareCellImageContainer(): Container(),
            widget._locationAttachmentProvider != null? ShareCellLocation(): Container(),
            widget._fileAttachmentProvider != null? ShareCellFileAttachment(): Container(),
            ShareCellAction(),
            ShareCellLikeCommentContainer()
          ],
        ),
      ),
    );
  }
}
