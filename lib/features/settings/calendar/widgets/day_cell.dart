import 'package:flutter/material.dart';
import '../half_circle_indicator.dart';

class DayCell extends StatelessWidget {
  final DateTime day;
  final bool morning;
  final bool evening;
  final bool isToday;
  final bool isSelected;
  final bool isOutside;

  const DayCell({
    super.key,
    required this.day,
    this.morning = false,
    this.evening = false,
    this.isToday = false,
    this.isSelected = false,
    this.isOutside = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [

        if (morning)
          CustomPaint(
            size: const Size(38, 38),
            painter: HalfCirclePainter(
              color: Colors.amber,
              isLeft: false,
            ),
          ),

        if (evening)
          CustomPaint(
            size: const Size(38, 38),
            painter: HalfCirclePainter(
              color: Colors.blue,
              isLeft: true,
            ),
          ),

        if (isToday)
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: 2),
            ),
          ),

        if (isSelected && !isToday)
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.purple, width: 2),
            ),
          ),

        Text(
          '${day.day}',
          style: TextStyle(
            color: isOutside
                ? Colors.grey[400]
                : isToday
                ? Colors.grey
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