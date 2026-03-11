import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:azkari_app/features/settings/Notifications/logic/app_lifecycle_provider.dart';
import '../../settings/Notifications/logic/notification_service.dart';
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

  @override
  void didUpdateWidget(CustomCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset state if index or type changes, even if GlobalKey reuses this State
    if (oldWidget.index != widget.index || oldWidget.type != widget.type) {
      _initController();
    }
  }

  void _initController() {
    _controller = CounterController(
      repository: CounterRepository(),
      index: widget.index,
      type: widget.type,
      repeat: widget.repeat,
      minRequired: widget.minRequired,
      totalAzkar: widget.totalAzkar,
    );

    setState(() {
      currentCount = _controller.loadCount();
    });
  }

  Future<void> decrement() async {
    if (currentCount <= 0) return;

    HapticFeedback.lightImpact();

    final newCount = await _controller.decrement(currentCount);
    setState(() => currentCount = newCount);

    final allCompleted = await _controller.handleZekrCompletion(currentCount);

    if (allCompleted) {
      getWindowLifecycleManager().resetProgress();

      if (widget.type == 'morning') {
        NotificationService().markMorningCompletedToday();
      } else if (widget.type == 'evening') {
        NotificationService().markEveningCompletedToday();
      }

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
