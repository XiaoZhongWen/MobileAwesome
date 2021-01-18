import 'package:flutter/foundation.dart';

class ShareContentProvider with ChangeNotifier {
  bool _isShowDetail;
  String _content;

  ShareContentProvider(String content) {
    _isShowDetail = false;
    _content = content;
  }

  bool get isShowDetail => _isShowDetail;
  String get content => _content;

  void switchContentDisplayState() {
    _isShowDetail = !_isShowDetail;
    notifyListeners();
  }
}