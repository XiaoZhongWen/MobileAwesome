import 'package:assassin_flutter_module/pages/share/models/share_comment.dart';

typedef SingleTapTriggered<T> = void Function(T value, int index);

class ShareCallbacksProvider {
  final void Function(int index) giveLike;
  final void Function(int index) cancelLike;
  final SingleTapTriggered<String> publishComment;
  final void Function(int index) retransmit;
  final void Function(int index) switchContentDisplayState;
  final SingleTapTriggered<List> onTapImageAttachment;
  final void Function(int index) onTapLocationAttachment;
  final void Function(int index) onTapDiskAttachment;
  final void Function(String phoneNum) onTapPhoneNumber;
  final void Function(String phoneNum) onTapWebLink;
  final void Function(String userId) onTapNickname;
  final SingleTapTriggered<ShareComment> deleteComment;
  final void Function(String url) saveToCloudDisk;
  final SingleTapTriggered collect;
  final void Function(String text) copy;
  final void Function(int index) delete;

  ShareCallbacksProvider({
    this.cancelLike,
    this.collect,
    this.copy,
    this.deleteComment,
    this.giveLike,
    this.onTapDiskAttachment,
    this.onTapImageAttachment,
    this.onTapLocationAttachment,
    this.onTapNickname,
    this.onTapPhoneNumber,
    this.onTapWebLink,
    this.publishComment,
    this.retransmit,
    this.saveToCloudDisk,
    this.switchContentDisplayState,
    this.delete
  });
}