import 'package:assassin_flutter_module/constants.dart';
import 'package:assassin_flutter_module/pages/share/models/share_content_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_header_provider.dart';
import 'package:assassin_flutter_module/pages/share/models/share_image_attachment_provider.dart';
import 'package:assassin_flutter_module/pages/share/widgets/share_cell_content.dart';
import 'package:assassin_flutter_module/pages/share/widgets/share_cell_header.dart';
import 'package:assassin_flutter_module/pages/share/widgets/share_cell_image_container.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ShareCell extends StatefulWidget {
  ShareHeaderProvider _headerProvider;
  ShareContentProvider _contentProvider;
  ShareImageAttachmentProvider _imageAttachmentProvider;

  ShareCell(
      String id,
      this._headerProvider,
      this._contentProvider,
      this._imageAttachmentProvider
      ): super(key: ValueKey(id));

  @override
  _ShareCellState createState() => _ShareCellState();
}

class _ShareCellState extends State<ShareCell> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: widget._headerProvider),
        ChangeNotifierProvider.value(value: widget._contentProvider),
        Provider.value(value: widget._imageAttachmentProvider)
      ],
      child: Container(
        margin: EdgeInsets.all(default_margin),
        child: Column(
          children: [
            ShareCellHeader(),
            ShareCellContent(),
            widget._imageAttachmentProvider != null? ShareCellImageContainer(): Container()
          ],
        ),
      ),
    );
  }
}
