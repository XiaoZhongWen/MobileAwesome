import 'package:assassin_flutter_module/pages/share/models/share_comment.dart';
import 'package:flutter/foundation.dart';

class ShareCommentsProvider with ChangeNotifier {
  ShareCommentsProvider({this.comments});

  List<ShareComment> comments;

  void addComment(ShareComment comment) {
    comments.add(comment);
    notifyListeners();
  }

  void removeComment(String id) {
    for (ShareComment comment in comments) {
      if (comment.id == id) {
        comments.remove(comment);
        notifyListeners();
        break;
      }
    }
  }
}