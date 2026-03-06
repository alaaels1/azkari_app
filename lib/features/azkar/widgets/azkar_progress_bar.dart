import 'package:flutter/material.dart';

class AzkarProgressBar extends StatelessWidget {
  final int currentIndex;
  final int totalCount;

  const AzkarProgressBar({
    super.key,
    required this.currentIndex,
    required this.totalCount,
  });

  double get _progress => (currentIndex + 1) / totalCount;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: LinearProgressIndicator(
        value: _progress,
        backgroundColor: Theme.of(context).dividerColor.withOpacity(0.1),
        valueColor: AlwaysStoppedAnimation<Color>(
          Theme.of(context).primaryColor,
        ),
        minHeight: 6,
      ),
    );
  }
}