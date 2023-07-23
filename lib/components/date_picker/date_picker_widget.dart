import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:meal_up/components/date_picker/gestures/tap.dart';
import 'package:meal_up/constant.dart';
import 'date_widget.dart';

class DatePicker extends StatefulWidget {
  final DateTime startDate;
  final double width;
  final double height;
  final DatePickerController? controller;
  final Color deactivatedColor;
  final TextStyle dayTextStyle;
  final TextStyle dateTextStyle;
  final TextStyle selectedDayTextStyle;
  final TextStyle selectedDateTextStyle;
  final DateTime? initialSelectedDate;
  final DateChangeListener? onDateChange;
  final int daysCount;
  final String locale;

  const DatePicker(
    this.startDate, {
    super.key,
    this.width = 60,
    this.height = 95,
    this.controller,
    this.dayTextStyle = defaultDayTextStyle,
    this.dateTextStyle = defaultDateTextStyle,
    this.selectedDayTextStyle = selectedDayStyle,
    this.selectedDateTextStyle = selectedDateStyle,
    this.deactivatedColor = const Color(0xFF666666),
    this.initialSelectedDate,
    this.daysCount = 500,
    this.onDateChange,
    this.locale = "en_US",
  });

  @override
  State<StatefulWidget> createState() => DatePickerState();
}

class DatePickerState extends State<DatePicker> {
  DateTime? _currentDate;

  final ScrollController _controller = ScrollController();

  late final TextStyle deactivatedDateStyle;
  late final TextStyle deactivatedDayStyle;

  Future<void> scrollToSelectedItem() async {
    await Future.delayed(const Duration(milliseconds: 1));
    final index = DateTime.now().difference(widget.startDate).inDays + 1;
    _controller
        .animateTo(
          _controller.position.maxScrollExtent *
              ((index - 2) / widget.daysCount),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        )
        .then((_) {});
  }

  @override
  void initState() {
    initializeDateFormatting(widget.locale, null);
    _currentDate = widget.initialSelectedDate;

    if (widget.controller != null) {
      widget.controller!.setDatePickerState(this);
    }

    deactivatedDateStyle =
        widget.dateTextStyle.copyWith(color: widget.deactivatedColor);
    deactivatedDayStyle =
        widget.dayTextStyle.copyWith(color: widget.deactivatedColor);

    scrollToSelectedItem();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: ListView.builder(
        itemCount: widget.daysCount,
        scrollDirection: Axis.horizontal,
        controller: _controller,
        itemBuilder: (context, index) {
          DateTime date;
          DateTime date1 = widget.startDate.add(Duration(days: index));
          date = DateTime(date1.year, date1.month, date1.day);

          bool isSelected =
              _currentDate != null ? _compareDate(date, _currentDate!) : false;

          // Return the Date Widget
          return DateWidget(
            date: date,
            dateTextStyle: isSelected
                ? widget.selectedDateTextStyle
                : widget.dateTextStyle,
            dayTextStyle:
                isSelected ? widget.selectedDayTextStyle : widget.dayTextStyle,
            width: widget.width,
            locale: widget.locale,
            selectionColor: isSelected ? primaryColor : Colors.transparent,
            selectionDateColor: isSelected ? Colors.white : Colors.transparent,
            hasData: true,
            onDateSelected: (selectedDate) {
              if (widget.onDateChange != null) {
                widget.onDateChange!(selectedDate);
              }
              setState(() {
                _currentDate = selectedDate;
              });
            },
          );
        },
      ),
    );
  }

  bool _compareDate(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }
}

class DatePickerController {
  DatePickerState? _datePickerState;

  void setDatePickerState(DatePickerState state) {
    _datePickerState = state;
  }

  void jumpToSelection() {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    _datePickerState!._controller
        .jumpTo(_calculateDateOffset(_datePickerState!._currentDate!));
  }

  void animateToSelection(
      {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    _datePickerState!._controller.animateTo(
        _calculateDateOffset(_datePickerState!._currentDate!),
        duration: duration,
        curve: curve);
  }

  void animateToDate(DateTime date,
      {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    _datePickerState!._controller.animateTo(_calculateDateOffset(date),
        duration: duration, curve: curve);
  }

  void setDateAndAnimate(DateTime date,
      {duration = const Duration(milliseconds: 500), curve = Curves.linear}) {
    assert(_datePickerState != null,
        'DatePickerController is not attached to any DatePicker View.');

    _datePickerState!._controller.animateTo(_calculateDateOffset(date),
        duration: duration, curve: curve);

    if (date.compareTo(_datePickerState!.widget.startDate) >= 0 &&
        date.compareTo(_datePickerState!.widget.startDate
                .add(Duration(days: _datePickerState!.widget.daysCount))) <=
            0) {
      _datePickerState!._currentDate = date;
    }
  }

  double _calculateDateOffset(DateTime date) {
    final startDate = DateTime(
        _datePickerState!.widget.startDate.year,
        _datePickerState!.widget.startDate.month,
        _datePickerState!.widget.startDate.day);

    int offset = date.difference(startDate).inDays;
    return (offset * _datePickerState!.widget.width) + (offset * 6);
  }
}
