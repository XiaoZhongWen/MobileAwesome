class ShareHeaderProvider {
  int _index;
  String _headUrl;
  String _publisherName;
  String _publisher;
  int _publishTime;

  ShareHeaderProvider(int index, String url, String name, String publisher, int time) {
    _index = index;
    _headUrl = url;
    _publisherName = name;
    _publishTime = time;
    _publisher = publisher;
  }

  String get headerUrl => _headUrl;
  String get publisherName => _publisherName;
  String get publisher => _publisher;
  int get publishTime => _publishTime;
  int get index => _index;
}