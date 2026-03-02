import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
class CustomCounter extends StatefulWidget {
  final int index;
  final String type;
  final int repeat;
  final int minRequired;
  final int totalAzkar; // ✅ عدد الأذكار الكلي
  final VoidCallback? onAllCompleted; // ✅ callback لما يخلص الكل

  const CustomCounter({
    super.key,
    required this.index,
    required this.type,
    required this.repeat,
    required this.totalAzkar,
    this.minRequired = 1,
    this.onAllCompleted,
  });

  @override
  State<CustomCounter> createState() => _CustomCounterState();
}

class _CustomCounterState extends State<CustomCounter> {
  late Box box;
  late int currentCount;

  String get today {
    final now = DateTime.now();
    return "${now.year}-${now.month}-${now.day}";
  }

  String get keyName => "${widget.type}_${widget.index}_$today";

  int get timesRead => widget.repeat - currentCount;

  bool get reachedMinimum => timesRead >= widget.minRequired;

  @override
  void initState() {
    super.initState();
    box = Hive.box('azkarBox');
    currentCount = box.get(keyName, defaultValue: widget.repeat);
  }

  void decrement() {
    if (currentCount > 0) {
      setState(() {
        currentCount--;
      });

      box.put(keyName, currentCount);

      if (reachedMinimum) {
        markZekrAsRead();
        checkIfAllAzkarCompleted();
      }
    }
  }

  void checkIfAllAzkarCompleted() {
    bool allCompleted = true;

    for (int i = 0; i < widget.totalAzkar; i++) {
      String key = "${widget.type}_zekr_${i}_$today";
      bool isRead = box.get(key, defaultValue: false);

      if (!isRead) {
        allCompleted = false;
        break;
      }
    }

    if (allCompleted) {
      String completedKey = "${widget.type}_completed_$today";
      box.put(completedKey, true);

      // ✅ ننتظر انتهاء الـ frame الحالي قبل ما نفتح الديالوج
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onAllCompleted?.call();
      });
    }
  }

  void markZekrAsRead() {
    String zekrKey = "${widget.type}_zekr_${widget.index}_$today";
    box.put(zekrKey, true);
  }


  @override
  Widget build(BuildContext context) {
    bool finished = currentCount == 0;

    return GestureDetector(
      onTap: decrement,
      child: Container(
        width: 70,
        height: 70,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: finished
              ? Colors.green
              : reachedMinimum
              ? Colors.orange
              : Colors.blueGrey[900],
        ),
        child: Text(
          "$currentCount",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}