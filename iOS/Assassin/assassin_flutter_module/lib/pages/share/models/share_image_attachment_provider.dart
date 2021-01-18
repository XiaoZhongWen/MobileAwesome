import 'package:assassin_flutter_module/pages/share/models/image_attachment.dart';

class ShareImageAttachmentProvider {
  ImageAttachment _attachment;

  ShareImageAttachmentProvider(ImageAttachment attachment) {
    _attachment = attachment;
  }

  ImageAttachment get attachment => _attachment;
}