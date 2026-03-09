import 'package:window_manager/window_manager.dart';
import 'notification_service.dart';

/// Manages window lifecycle events and triggers notifications
class WindowLifecycleManager extends WindowListener {
  double _azkarProgress = 0;

  /// Call this when azkar progress changes (0-100)
  void updateAzkarProgress(double progress) {
    _azkarProgress = progress;
  }

  /// Reset progress when azkar is completed
  void resetProgress() {
    _azkarProgress = 0;
  }

  /// Called when window loses focus (user switches to another app)
  @override
  void onWindowBlur() {
    NotificationService().notifyIfIncompleteAzkar(progress: _azkarProgress);
  }

  /// Called when window is minimized
  @override
  void onWindowMinimize() {
    NotificationService().notifyIfIncompleteAzkar(progress: _azkarProgress);
  }

  /// Called when window regains focus - cancel incomplete notification
  @override
  void onWindowFocus() {
    NotificationService().cancelIncompleteAzkarNotification();
  }
}
