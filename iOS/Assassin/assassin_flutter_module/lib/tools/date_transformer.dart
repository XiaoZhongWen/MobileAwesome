import 'package:date_format/date_format.dart';

class DateTransformer {
  DateTransformer._privateConstructor();
  static DateTransformer shared = DateTransformer._privateConstructor();
  factory DateTransformer() {
    return shared;
  }

  String sharePublishTime(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    DateTime now = DateTime.now();
    String publishTime = "";
    if (dateTime.year != now.year ||
        dateTime.month != now.month) {
      publishTime = formatDate(dateTime, [yyyy, '年', mm, '月', dd, '日 ', HH, ':', nn]);
    } else {
      if (dateTime.day == now.day) {
        publishTime = "今天" + " " + formatDate(dateTime, [HH, ':', nn]);
      } else if (now.day - dateTime.day == 1) {
        publishTime = "昨天" + " " + formatDate(dateTime, [HH, ':', nn]);
      } else {
        publishTime = formatDate(dateTime, [mm, '月', dd, '日 ', HH, ':', nn]);
      }
    }
    return publishTime;
  }
}