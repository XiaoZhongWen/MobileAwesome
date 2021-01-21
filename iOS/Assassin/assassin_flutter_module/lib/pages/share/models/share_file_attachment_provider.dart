import 'package:assassin_flutter_module/pages/share/models/disk_attachment.dart';

class ShareFileAttachmentProvider {
  int _index;
  DiskAttachment _attachment;

  ShareFileAttachmentProvider(int index, DiskAttachment attachment) {
    _index = index;
    _attachment = attachment;
  }

  DiskAttachment get attachment => _attachment;
  int get index => _index;
}