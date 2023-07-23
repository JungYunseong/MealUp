int dateTimeToInt(DateTime dateTime) {
  DateTime date = DateTime(dateTime.year, dateTime.month, dateTime.day);
  int dateInt = date.millisecondsSinceEpoch;
  return dateInt;
}

DateTime intToDateTime(int dateInt) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dateInt);
  return dateTime;
}

String getDayOfWeek(DateTime date) {
  List<String> daysOfWeek = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];
  int dayIndex = date.weekday - 1;

  return daysOfWeek[dayIndex];
}

String converToReleativeDate(int dateTime) {
  final now = DateTime.now();
  final inputDate = intToDateTime(dateTime);
  final duration = now.difference(inputDate);
  final int dayInterval = duration.inDays.abs();

  switch (dayInterval) {
    case 0:
      return '오늘';
    case 1:
      return '어제';
    case 2:
      return '이틀 전';
    case 3:
      return '3일 전';
    default:
      String result = '${inputDate.day} 일, ${getDayOfWeek(inputDate)}';
      if (now.month != inputDate.month) {
        result = '${inputDate.month}월 $result';
      }
      if (now.year != inputDate.year) {
        result = '${inputDate.year}년 $result';
      }

      return result;
  }
}
