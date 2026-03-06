import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import '../data/counter_repository.dart';
import '../logic/counter_controller.dart';
import 'counter_display.dart';

class CustomCounter extends StatefulWidget {
  final int index;
  final String type;
  final int repeat;
  final int minRequired;
  final int totalAzkar;
  final VoidCallback? onAllCompleted;

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
  State<CustomCounter> createState() => CustomCounterState();
}

class CustomCounterState extends State<CustomCounter> {

  late CounterController _controller;
  late int currentCount;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  void _initController() {
    final repository = CounterRepository(Hive.box('azkarBox'));

    _controller = CounterController(
      repository: repository,
      index: widget.index,
      type: widget.type,
      repeat: widget.repeat,
      minRequired: widget.minRequired,
      totalAzkar: widget.totalAzkar,
    );

    currentCount = _controller.loadCount();
  }



  Future<void> decrement() async {
    if (currentCount <= 0) return;

    HapticFeedback.lightImpact();

    final newCount = await _controller.decrement(currentCount);

    setState(() => currentCount = newCount);

    final allCompleted = await _controller.handleZekrCompletion(currentCount);

    if (allCompleted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onAllCompleted?.call();
      });
    }

    if (_controller.isFinished(currentCount)) {
      HapticFeedback.heavyImpact();
    }
  }

  Future<void> increment() async {
    if (currentCount >= widget.repeat) return;

    HapticFeedback.lightImpact();

    final newCount = await _controller.increment(currentCount);
    setState(() => currentCount = newCount);
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: decrement,

      child: CounterDisplay(
        currentCount: currentCount,
        progress: _controller.progress(currentCount),
        isFinished: _controller.isFinished(currentCount),
        reachedMinimum: _controller.reachedMinimum(currentCount),
      ),
    );
  }
}