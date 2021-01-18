import 'package:assassin_flutter_module/pages/share/models/disk_attachment.dart';

class ShareFileAttachmentProvider {
  DiskAttachment _attachment;

  ShareFileAttachmentProvider(DiskAttachment attachment) {
    _attachment = attachment;
  }

  DiskAttachment get attachment => _attachment;
}