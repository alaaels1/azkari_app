import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../../../../core/utils/completion_dialog.dart';
import '../../counter/logic/counter_controller.dart';
import '../../counter/widgets/custom_counter.dart';
import 'azkar_content_card.dart';
import 'azkar_navigation_arrows.dart';
import 'azkar_progress_bar.dart';


class AzkarBody extends StatelessWidget {
  final List azkarList;
  final int currentIndex;
  final CounterController controller;
  final String type;
  final String title;
  final VoidCallback onNext;
  final VoidCallback onPrevious;

  const AzkarBody({
    super.key,
    required this.azkarList,
    required this.currentIndex,
    required this.controller,
    required this.type,
    required this.title,
    required this.onNext,
    required this.onPrevious,
  });

  @override
  Widget build(BuildContext context) {
    final zekr = azkarList[currentIndex];

    return Stack(
      children: [
        Column(
          children: [
            AzkarProgressBar(
              currentIndex: currentIndex,
              totalCount: azkarList.length,
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Center(
                child: AzkarContentCard(
                  zekrText: zekr.zekr,
                  blessText: zekr.bless,
                ),
              ),
            ),
            CustomCounter(
              index: currentIndex,
              type: type,
              repeat: zekr.repeat,
              minRequired: 1,
              totalAzkar: azkarList.length,
              onAllCompleted: () =>
                  showCompletionDialog(context, title), // ✅ مش hardcoded
            ),
            const SizedBox(height: 40),
          ],
        ),
        AzkarNavigationArrows(
          canGoNext: !controller.isLastZekr,
          canGoPrevious: currentIndex > 0,
          onNext: onNext,
          onPrevious: onPrevious,
        ),
      ],
    );
  }
}