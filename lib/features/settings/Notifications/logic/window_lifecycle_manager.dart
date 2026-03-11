import 'dart:async';
import 'package:window_manager/window_manager.dart';
import 'notification_service.dart';

class WindowLifecycleManager extends WindowListener {
  double _azkarProgress = 0;
  Timer? _blurTimer;
  bool _notificationWasSent = false;

  void updateAzkarProgress(double progress) => _azkarProgress = progress;

  void resetProgress() {
    _azkarProgress = 0;
    _notificationWasSent = false;
    NotificationService().cancelIncompleteAzkarNotification();
  }

  void _handleAppHidden() {
    _blurTimer?.cancel();
    _blurTimer = Timer(const Duration(seconds: 1), () async {
      if (_azkarProgress > 0 && _azkarProgress < 100) {
        await NotificationService()
            .onAppBackground(progress: _azkarProgress);
        _notificationWasSent = true;
      }
    });
  }

  void _handleAppVisible() {
    _blurTimer?.cancel();
    if (_notificationWasSent) {
      NotificationService().cancelIncompleteAzkarNotification();
      _notificationWasSent = false;
    }
  }

  @override
  void onWindowBlur() => _handleAppHidden();

  @override
  void onWindowMinimize() => _handleAppHidden();

  @override
  void onWindowFocus() {
    _handleAppVisible();
    windowManager.show();
    windowManager.focus();
  }

  @override
  void onWindowRestore() {
    _handleAppVisible();
    windowManager.show();
    windowManager.focus();
  }
}