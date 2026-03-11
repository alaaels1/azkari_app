import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../data/notification_messages.dart';
import '../repo/notification_repo.dart';
import 'dart:io';


class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  late FlutterLocalNotificationsPlugin _plugin;
  final _repo = NotificationRepository();

  static const int morningReminderId = 1;
  static const int eveningReminderId = 2;
  static const int incompleteAzkarId = 3;

  static const int maxNotifPerDay             = 3;
  static const int minGapBetweenNotifsMinutes = 60;
  static const int launchDelaySeconds         = 30;
  static const int maxIncompleteReminders     = 3;
  static const int incompleteGapMinutes       = 30;

  NotificationService._internal();
  factory NotificationService() => _instance;

  // ── Init ──────────────────────────────────────────
  Future<void> initialize() async {
    _plugin = FlutterLocalNotificationsPlugin();

    await _plugin.initialize(
      settings: InitializationSettings(
        // ✅ Windows
        windows: Platform.isWindows
            ? const WindowsInitializationSettings(
          appName: 'Azkari App',
          appUserModelId: 'com.azkari.app',
          guid: '12345678-1234-1234-1234-123456789012',
          iconPath: 'windows/runner/resources/app_icon.ico',
        )
            : null,
        // ✅ Linux
        linux: Platform.isLinux
            ? const LinuxInitializationSettings(
          defaultActionName: 'open',
        )
            : null,
      ),
    );
  }

  // ── Show ──────────────────────────────────────────
  Future<void> _show({
    required int id,
    required String title,
    required String body,
  }) async {
    try {
      await _plugin.show(
        id: id,
        title: '\u200F$title',
        body: '\u200F$body',
        notificationDetails: NotificationDetails(
          // ✅ Windows
          windows: Platform.isWindows
              ? const WindowsNotificationDetails(
            duration: WindowsNotificationDuration.short,
          )
              : null,
          // ✅ Linux
          linux: Platform.isLinux
              ? const LinuxNotificationDetails()
              : null,
        ),
      );
    } catch (e) {
      print('Error showing notification: $e');
    }
  }

  // ── Can Notify ────────────────────────────────────
  bool _canNotify(String countKey, String lastTimeKey) {
    if (!_repo.notificationsEnabled) return false;
    if (_repo.getNotifCountToday(countKey) >= maxNotifPerDay) return false;
    if (!_repo.isEnoughTimePassed(lastTimeKey, minGapBetweenNotifsMinutes)) return false;
    return true;
  }

  void _afterNotif(String countKey, String lastTimeKey) {
    _repo.incrementNotifCount(countKey);
    _repo.saveLastNotifTime(lastTimeKey);
  }

  // ── Morning ───────────────────────────────────────
  Future<void> checkAndNotifyMorningOnLaunch() async {
    await Future.delayed(const Duration(seconds: launchDelaySeconds));
    final hour = DateTime.now().hour;
    if (hour < 5 || hour >= 15) return;
    if (_repo.isMorningCompleted) return;
    if (!_canNotify(
      NotificationRepository.morningNotifCountKey,
      NotificationRepository.morningLastTimeKey,
    )) return;

    await _show(
      id: morningReminderId,
      title: 'أذكار الصباح 🌅',
      body: NotificationMessages.getRandomMorningMessage(),
    );
    _afterNotif(
      NotificationRepository.morningNotifCountKey,
      NotificationRepository.morningLastTimeKey,
    );
  }

  // ── Evening ───────────────────────────────────────
  Future<void> checkAndNotifyEveningOnLaunch() async {
    await Future.delayed(const Duration(seconds: launchDelaySeconds));
    final now = DateTime.now();
    final isAfter330PM =
        now.hour > 15 || (now.hour == 15 && now.minute >= 30);
    if (!isAfter330PM) return;
    if (_repo.isEveningCompleted) return;
    if (!_canNotify(
      NotificationRepository.eveningNotifCountKey,
      NotificationRepository.eveningLastTimeKey,
    )) return;

    await _show(
      id: eveningReminderId,
      title: 'أذكار المساء 🌙',
      body: NotificationMessages.getRandomEveningMessage(),
    );
    _afterNotif(
      NotificationRepository.eveningNotifCountKey,
      NotificationRepository.eveningLastTimeKey,
    );
  }

  // ── Incomplete Azkar ──────────────────────────────
  Future<void> onAppBackground({required double progress}) async {
    if (!_repo.notificationsEnabled) return;
    if (progress <= 0 || progress >= 100) return;

    final sentCount = _repo.getIncompleteReminderCount();
    if (sentCount >= maxIncompleteReminders) return;
    if (!_repo.isEnoughTimePassed(
      NotificationRepository.incompleteLastTimeKey,
      incompleteGapMinutes,
    )) return;

    await _show(
      id: incompleteAzkarId,
      title: _getIncompleteTitle(sentCount),
      body: _getIncompleteBody(progress),
    );

    _repo.incrementIncompleteReminderCount();
    _repo.saveLastNotifTime(NotificationRepository.incompleteLastTimeKey);
  }

  String _getIncompleteTitle(int sentCount) {
    switch (sentCount) {
      case 0: return 'لم تكمل أذكارك 📿';
      case 1: return 'أذكارك في انتظارك 🤲';
      case 2: return 'آخر تذكير بأذكارك ⭐';
      default: return 'لم تكمل أذكارك 📿';
    }
  }

  String _getIncompleteBody(double progress) {
    if (progress < 30) {
      return 'خطوة موفقة! أكمل أذكارك وأتم الأجر.';
    } else if (progress < 70) {
      return 'أكملت جزءاً من أذكارك، أكمل الباقي لتتم أجرك.';
    } else {
      return 'اقتربت من الإتمام! بقي القليل، لا تفوّت الأجر.';
    }
  }

  Future<void> cancelIncompleteAzkarNotification() async {
    try {
      await _plugin.cancel(id: incompleteAzkarId);
    } catch (e) {
      print('Error canceling notification: $e');
    }
  }

  void resetIncompleteReminders() {
    _repo.resetIncompleteReminderCount();
    cancelIncompleteAzkarNotification();
  }

  void markMorningCompletedToday() {
    _repo.markMorningCompleted();
    resetIncompleteReminders();
  }

  void markEveningCompletedToday() {
    _repo.markEveningCompleted();
    resetIncompleteReminders();
  }
}