class ShareHeaderProvider {
  String _headUrl;
  String _publisherName;
  int _publishTime;

  ShareHeaderProvider(String url, String name, int time) {
    _headUrl = url;
    _publisherName = name;
    _publishTime = time;
  }

  String get headerUrl => _headUrl;
  String get publisherName => _publisherName;
  int get publishTime => _publishTime;
}