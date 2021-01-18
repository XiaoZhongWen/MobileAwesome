import 'package:assassin_flutter_module/pages/share/models/location_attachment.dart';

class ShareLocationAttachmentProvider {
  LocationAttachment _attachment;

  ShareLocationAttachmentProvider(LocationAttachment attachment) {
    _attachment = attachment;
  }

  LocationAttachment get attachment => _attachment;
}