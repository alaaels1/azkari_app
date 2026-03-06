import 'package:flutter/material.dart';

abstract class CounterUIHelper {


  static Color backgroundColor({
    required bool isFinished,
    required bool reachedMinimum,
  }) {
    if (isFinished) return Colors.green;
    if (reachedMinimum) return Colors.orange;
    return Colors.blueGrey[800]!;
  }

  static Color progressColor({
    required bool isFinished,
    required bool reachedMinimum,
  }) {
    if (isFinished) return Colors.green[300]!;
    if (reachedMinimum) return Colors.orange[300]!;
    return Colors.blue[300]!;
  }


  static const double outerSize = 75.0;
  static const double innerSize = 65.0;
  static const double strokeWidth = 4.0;
  static const double iconSize = 30.0;
  static const double fontSize = 22.0;
}