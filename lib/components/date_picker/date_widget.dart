/// ***
/// This class consists of the DateWidget that is used in the ListView.builder
///
/// Author: Vivek Kaushik <me@vivekkasuhik.com>
/// github: https://github.com/iamvivekkaushik/
/// ***

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'gestures/tap.dart';

class DateWidget extends StatelessWidget {
  final double? width;
  final DateTime date;
  final TextStyle? dayTextStyle, dateTextStyle;
  final Color selectionColor;
  final Color selectionDateColor;
  final bool hasData;
  final DateSelectionCallback? onDateSelected;
  final String? locale;

  const DateWidget({
    super.key,
    required this.date,
    required this.dayTextStyle,
    required this.dateTextStyle,
    required this.selectionColor,
    required this.selectionDateColor,
    required this.hasData,
    this.width,
    this.onDateSelected,
    this.locale,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Container(
        width: width,
        margin: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
          color: selectionColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  DateFormat('E', locale).format(date).toUpperCase(), // Month
                  style: dayTextStyle,
                ),
              ),
              Container(
                width: 34.0,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  color: selectionDateColor,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      date.day.toString(), // Date
                      style: dateTextStyle,
                    ),
                  ),
                ),
              ),
              Container(
                width: 6.0,
                height: 6.0,
                decoration: BoxDecoration(
                  color: hasData ? Colors.white : Colors.transparent,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
        ),
      ),
      onPressed: () {
        if (onDateSelected != null) {
          onDateSelected!(date);
        }
      },
    );
  }
}
