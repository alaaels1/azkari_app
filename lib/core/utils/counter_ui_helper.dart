import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  static double get outerSize => 75.0.r;
  static double get innerSize => 65.0.r;
  static double get strokeWidth => 4.0.w;
  static double get iconSize => 30.0.r;
  static double get fontSize => 22.0.sp;
}
