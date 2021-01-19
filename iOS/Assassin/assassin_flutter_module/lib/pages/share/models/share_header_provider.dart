class ShareHeaderProvider {
  String _headUrl;
  String _publisherName;
  String _publisher;
  int _publishTime;

  ShareHeaderProvider(String url, String name, String publisher, int time) {
    _headUrl = url;
    _publisherName = name;
    _publishTime = time;
    _publisher = publisher;
  }

  String get headerUrl => _headUrl;
  String get publisherName => _publisherName;
  String get publisher => _publisher;
  int get publishTime => _publishTime;
}