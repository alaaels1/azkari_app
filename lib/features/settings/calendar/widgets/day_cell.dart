import 'package:flutter/material.dart';
import 'half_circle_indicator.dart';
import 'hijri_helper.dart';
import 'calendar_type_selector.dart';

class DayCell extends StatelessWidget {
  final DateTime day;
  final bool morning;
  final bool evening;
  final bool isToday;
  final bool isSelected;
  final bool isOutside;
  final CalendarType calendarType;
  final int hijriOffset;

  const DayCell({
    super.key,
    required this.day,
    this.morning = false,
    this.evening = false,
    this.isToday = false,
    this.isSelected = false,
    this.isOutside = false,
    this.calendarType = CalendarType.gregorian,
    this.hijriOffset = 0,
  });

  @override
  Widget build(BuildContext context) {
    String dayText = calendarType == CalendarType.hijri
        ? HijriHelper.getHijriDay(day, offset: hijriOffset)
        : day.day.toString();

    return Stack(
      alignment: Alignment.center,
      children: [
        if (morning)
          CustomPaint(
            size: const Size(38, 38),
            painter: HalfCirclePainter(color: Colors.amber, isLeft: false),
          ),
        if (evening)
          CustomPaint(
            size: const Size(38, 38),
            painter: HalfCirclePainter(color: Colors.blue, isLeft: true),
          ),
        if (isToday)
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
          ),
        if (isSelected && !isToday)
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Theme.of(context).hintColor, width: 2),
            ),
          ),
        Text(
          dayText,
          style: TextStyle(
            color: isOutside
                ? Colors.white
                : isToday
                ? Theme.of(context).primaryColor
                : null,
            fontWeight: isToday || morning || evening
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
