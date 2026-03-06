import 'package:flutter/material.dart';

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
    final double midHeight = MediaQuery.of(context).size.height * 0.4;

    return Stack(
      children: [
        Positioned(
          left: 2,
          top: midHeight,
          child: IconButton(
            onPressed: canGoNext ? onNext : null,
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),

        Positioned(
          right: 2,
          top: midHeight,
          child: IconButton(
            onPressed: canGoPrevious ? onPrevious : null,
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ],
    );
  }
}