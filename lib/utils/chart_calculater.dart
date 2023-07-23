import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:meal_up/utils/date_coverter.dart';
import '../model/weight.dart';

typedef MinMax = (double max, double min);

double getMaxX(List<WeightEntry> list) {
  List<int> refinedList = [];
  for (WeightEntry weightData in list) {
    refinedList.add(weightData.date);
  }
  final maxX = refinedList.reduce(max);

  return maxX.toDouble();
}

double getMinX({required String chartType, required List<WeightEntry> list}) {
  final maxX = getMaxX(list);
  switch (chartType) {
    case 'Weekly':
      final minX = maxX - 518400000;
      return minX;
    case 'Monthly':
      final minX = maxX - 3628800000;
      return minX;
    default:
      return 0;
  }
}

double getMinY(List<WeightEntry> list) {
  final minWeight = getMinMaxWeight(list).$2;
  return (minWeight ~/ 5) * 5;
}

double getMaxY(List<WeightEntry> list) {
  final maxWeight = getMinMaxWeight(list).$1;
  return ((maxWeight + 4) ~/ 5) * 5;
}

MinMax getMinMaxWeight(List<WeightEntry> list) {
  List<double> refinedList = [];
  for (WeightEntry weight in list) {
    refinedList.add(weight.weight);
  }
  final maxWeight = refinedList.reduce(max);
  final minWeight = refinedList.reduce(min);

  return (maxWeight, minWeight);
}

double getYInterval(List<WeightEntry> list) {
  final minMax = getMinMaxWeight(list);
  final range = minMax.$1 - minMax.$2;
  final interval = range / 4;
  if (interval < 5) {
    return 5;
  } else {
    return ((interval + 4) ~/ 5) * 5;
  }
}

int weekOfMonthForSimple(DateTime date) {
  DateTime firstDay = DateTime(date.year, date.month, 1);
  DateTime firstMonday = firstDay
      .add(Duration(days: (DateTime.monday + 7 - firstDay.weekday) % 7));
  final bool isFirstDayMonday = firstDay == firstMonday;
  final different = calculateDaysBetween(from: firstMonday, to: date);
  int weekOfMonth = (different / 7 + (isFirstDayMonday ? 1 : 2)).toInt();
  return weekOfMonth;
}

bool isSameWeek(DateTime dateTime1, DateTime dateTime2) {
  final int dateTime1WeekOfMonth = weekOfMonthForSimple(dateTime1);
  final int dateTime2WeekOfMonth = weekOfMonthForSimple(dateTime2);
  return dateTime1WeekOfMonth == dateTime2WeekOfMonth;
}

int calculateDaysBetween({required DateTime from, required DateTime to}) {
  return (to.difference(from).inHours / 24).round();
}

int weekOfMonthForStandard(DateTime date) {
  late int weekOfMonth;
  final firstDay = DateTime(date.year, date.month, 1);
  final lastDay = DateTime(date.year, date.month + 1, 0);

  final isFirstDayBeforeThursday = firstDay.weekday <= DateTime.thursday;

  if (isSameWeek(date, firstDay)) {
    if (isFirstDayBeforeThursday) {
      weekOfMonth = 1;
    } else {
      final lastDayOfPreviousMonth = DateTime(date.year, date.month, 0);
      weekOfMonth = weekOfMonthForStandard(lastDayOfPreviousMonth);
    }
  } else {
    if (isSameWeek(date, lastDay)) {
      final isLastDayBeforeThursday = lastDay.weekday >= DateTime.thursday;
      if (isLastDayBeforeThursday) {
        weekOfMonth =
            weekOfMonthForSimple(date) + (isFirstDayBeforeThursday ? 0 : -1);
      } else {
        weekOfMonth = 1;
      }
    } else {
      weekOfMonth =
          weekOfMonthForSimple(date) + (isFirstDayBeforeThursday ? 0 : -1);
    }
  }

  return weekOfMonth;
}

String converXtoString({required String chartType, required int x}) {
  final dateTime = intToDateTime(x);

  if (chartType == 'Weekly') {
    List<String> daysOfWeek = ['월', '화', '수', '목', '금', '토', '일'];
    int dayIndex = dateTime.weekday - 1;

    return '${daysOfWeek[dayIndex]}요일';
  } else {
    final month = dateTime.month;
    final week = weekOfMonthForStandard(intToDateTime(x));
    return '$month월 $week째주';
  }
}

Widget converXtoLabel({
  required String chartType,
  required List<WeightEntry> list,
  required double value,
  required TextStyle style,
}) {
  String label = '';
  if (chartType == 'Weekly') {
    final maxX = getMaxX(list);
    const interval = 86400000;

    if (value == maxX ||
        value == maxX - (interval * 2) ||
        value == maxX - (interval * 4) ||
        value == maxX - (interval * 6)) {
      label = converXtoString(chartType: chartType, x: value.toInt());
    }
  } else {
    final maxX = getMaxX(list);
    const interval = 604800000;
    if (value == maxX - (interval * 1) ||
        value == maxX - (interval * 3) ||
        value == maxX - (interval * 5)) {
      label = converXtoString(chartType: chartType, x: value.toInt());
    }
  }
  return Text(label, style: style);
}

String converYtoLabel({
  required double value,
  required TextStyle style,
}) {
  final label = '   ${value.toInt().toString()}';
  return label;
}
