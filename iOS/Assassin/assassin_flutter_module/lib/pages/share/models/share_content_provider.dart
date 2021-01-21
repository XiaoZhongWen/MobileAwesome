import 'package:flutter/foundation.dart';

class ShareContentProvider with ChangeNotifier {
  int _index;
  bool _isShowDetail;
  String _content;

  ShareContentProvider(int index, String content) {
    _index = index;
    _isShowDetail = false;
    _content = content;
  }

  bool get isShowDetail => _isShowDetail;
  String get content => _content;
  int get index => _index;

  void switchContentDisplayState() {
    _isShowDetail = !_isShowDetail;
    notifyListeners();
  }
}