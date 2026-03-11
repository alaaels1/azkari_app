import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AzkarNavigationArrows extends StatelessWidget {
  final bool canGoNext;
  final bool canGoPrevious;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const AzkarNavigationArrows({
    super.key,
    required this.canGoNext,
    required this.canGoPrevious,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    final double midHeight = 0.4.sh;

    return Stack(
      children: [
        Positioned(
          left: 2.w,
          top: midHeight,
          child: IconButton(
            onPressed: canGoNext ? onNext : null,
            icon: Icon(Icons.arrow_back_ios, size: 24.r),
          ),
        ),

        Positioned(
          right: 2.w,
          top: midHeight,
          child: IconButton(
            onPressed: canGoPrevious ? onPrevious : null,
            icon: Icon(Icons.arrow_forward_ios, size: 24.r),
          ),
        ),
      ],
    );
  }
}
