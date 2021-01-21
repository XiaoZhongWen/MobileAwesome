import 'package:assassin_flutter_module/pages/share/models/location_attachment.dart';

class ShareLocationAttachmentProvider {
  int _index;
  LocationAttachment _attachment;

  ShareLocationAttachmentProvider(int index, LocationAttachment attachment) {
    _index = index;
    _attachment = attachment;
  }

  LocationAttachment get attachment => _attachment;
  int get index => _index;
}