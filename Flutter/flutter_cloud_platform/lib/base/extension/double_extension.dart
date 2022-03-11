extension ExDouble on double {
  String get chatTime {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(toInt() * 1000);
    DateTime now = DateTime.now();
    String time = '';
    int year = date.year;
    int month = date.month;
    int day = date.day;
    int hour = date.hour;
    int min = date.minute;

    String m = month < 10? '0$month': '$month';
    String d = day < 10? '0$day': '$day';
    String h = hour < 10? '0$hour': '$hour';
    String mi = min < 10? '0$min': '$min';
    if (now.year != date.year || now.month != date.month) {
      time = '$year年$m月$d日 $h:$mi';
    } else {
      if (now.day - date.day > 7) {
        time = '$year年$m月$d日 $h:$mi';
      } else if (now.day - date.day > 1 && now.day - date.day <= 7) {
        time = ['星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期日'][date.weekday] + ' $h:$mi';
      } else if (now.day - date.day == 1) {
        time = '昨天 $h:$mi';
      } else {
        time = '$h:$mi';
      }
    }
    return time;
  }
}