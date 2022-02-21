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
    if (now.year != date.year || now.month != date.month) {
      time = '$year年$month月$day日 $hour:$min';
    } else {
      if (now.day - date.day > 7) {
        time = '$year年$month月$day日 $hour:$min';
      } else if (now.day - date.day > 1 && now.day - date.day <= 7) {
        time = ['星期一', '星期二', '星期三', '星期四', '星期五', '星期六', '星期日'][date.weekday] + ' $hour:$min';
      } else if (now.day - date.day == 1) {
        time = '昨天 $hour:$min';
      } else {
        time = '$hour:$min';
      }
    }
    return time;
  }
}