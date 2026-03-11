import 'package:flutter/material.dart';
import '../../../core/utils/counter_ui_helper.dart';

class CounterDisplay extends StatelessWidget {
  final int currentCount;
  final double progress;
  final bool isFinished;
  final bool reachedMinimum;

  const CounterDisplay({
    super.key,
    required this.currentCount,
    required this.progress,
    required this.isFinished,
    required this.reachedMinimum,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        _buildProgressRing(),
        _buildInnerCircle(),
      ],
    );
  }

  Widget _buildProgressRing() {
    return SizedBox(
      width: CounterUIHelper.outerSize,
      height: CounterUIHelper.outerSize,
      child: CircularProgressIndicator(
        value: progress,
        strokeWidth: CounterUIHelper.strokeWidth,
        backgroundColor: Colors.grey[300],
        valueColor: AlwaysStoppedAnimation<Color>(
          CounterUIHelper.progressColor(
            isFinished: isFinished,
            reachedMinimum: reachedMinimum,
          ),
        ),
      ),
    );
  }

  Widget _buildInnerCircle() {
    return Container(
      width: CounterUIHelper.innerSize,
      height: CounterUIHelper.innerSize,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: CounterUIHelper.backgroundColor(
          isFinished: isFinished,
          reachedMinimum: reachedMinimum,
        ),
      ),
      child: isFinished ? _buildCheckIcon() : _buildCountText(),
    );
  }

  Widget _buildCheckIcon() {
    return Icon(
      Icons.check,
      color: Colors.white,
      size: CounterUIHelper.iconSize,
    );
  }

  Widget _buildCountText() {
    return Text(
      "$currentCount",
      style: TextStyle(
        color: Colors.white,
        fontSize: CounterUIHelper.fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
