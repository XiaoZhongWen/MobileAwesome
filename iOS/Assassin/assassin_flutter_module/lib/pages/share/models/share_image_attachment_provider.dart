import 'package:assassin_flutter_module/pages/share/models/image_attachment.dart';

class ShareImageAttachmentProvider {
  int _index;
  ImageAttachment _attachment;

  ShareImageAttachmentProvider(int index, ImageAttachment attachment) {
    _index = index;
    _attachment = attachment;
  }

  ImageAttachment get attachment => _attachment;
  int get index => _index;
}