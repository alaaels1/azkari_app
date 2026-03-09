import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:azkari_app/features/settings/Notifications/app_lifecycle_provider.dart';
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

  /// Update window lifecycle manager with current azkar progress
  void _updateProgressNotification(int currentIndex, int totalCount) {
    final progress = ((currentIndex + 1) / totalCount) * 100;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getWindowLifecycleManager().updateAzkarProgress(progress);
    });
  }

  @override
  Widget build(BuildContext context) {
    final zekr = azkarList[currentIndex];
    _updateProgressNotification(currentIndex, azkarList.length);

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
              key: ValueKey('${type}_$currentIndex'),
              index: currentIndex,
              type: type,
              repeat: zekr.repeat,
              minRequired: 1,
              totalAzkar: azkarList.length,
              onAllCompleted: () =>
                  showCompletionDialog(context, title),
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
