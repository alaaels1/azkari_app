import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'notification_messages.dart';

/// Singleton notification service for handling local notifications
/// No internet required - all time checks use device local time only
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  late FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  // Notification IDs
  static const int morningReminderId = 1;
  static const int eveningReminderId = 2;
  static const int incompleteAzkarId = 3;

  // Hive storage keys
  static const String lastMorningNotifDateKey = 'lastMorningNotifDate';
  static const String lastEveningNotifDateKey = 'lastEveningNotifDate';
  static const String morningCompletedKey = 'morningCompleted';
  static const String eveningCompletedKey = 'eveningCompleted';

  NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  /// Initialize the notification service - call this once in main.dart
  Future<void> initialize() async {
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const InitializationSettings initializationSettings =
        InitializationSettings(
          windows: WindowsInitializationSettings(
            appName: 'Azkari App',
            appUserModelId: 'com.azkari.app',
            guid: '12345678-1234-1234-1234-123456789012',
          ),
        );

    await _flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
    );
  }

  /// Get today's date as a string (YYYY-MM-DD)
  String _getTodayDate() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  /// Check if a notification was already shown today
  bool _wasNotificationShownToday(String storageKey) {
    try {
      final box = Hive.box('azkarBox');
      final lastDate = box.get(storageKey) as String?;
      return lastDate == _getTodayDate();
    } catch (e) {
      return false;
    }
  }

  /// Mark that a notification was shown today
  void _markNotificationShownToday(String storageKey) {
    try {
      final box = Hive.box('azkarBox');
      box.put(storageKey, _getTodayDate());
    } catch (e) {
      print('Error saving notification date: $e');
    }
  }

  /// Check if morning azkar was completed today
  bool _isMorningCompletedToday() {
    try {
      final box = Hive.box('azkarBox');
      final lastCompletedDate = box.get('morningCompletedDate') as String?;
      return lastCompletedDate == _getTodayDate();
    } catch (e) {
      return false;
    }
  }

  /// Check if evening azkar was completed today
  bool _isEveningCompletedToday() {
    try {
      final box = Hive.box('azkarBox');
      final lastCompletedDate = box.get('eveningCompletedDate') as String?;
      return lastCompletedDate == _getTodayDate();
    } catch (e) {
      return false;
    }
  }

  /// Show an instant notification
  Future<void> _showInstantNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    try {
      const NotificationDetails platformChannelSpecifics = NotificationDetails(
        windows: WindowsNotificationDetails(),
      );

      await _flutterLocalNotificationsPlugin.show(
        id: id,
        title: title,
        body: body,
        notificationDetails: platformChannelSpecifics,
      );
    } catch (e) {
      print('Error showing notification: $e');
    }
  }

  /// Check if notifications are enabled in settings
  bool _areNotificationsEnabled() {
    try {
      final box = Hive.box('azkarBox');
      return box.get('notificationsEnabled', defaultValue: true) as bool;
    } catch (e) {
      return true; // Default to enabled if there's an error
    }
  }

  /// SCENARIO 1: Check and notify for morning azkar on app launch
  /// Conditions:
  /// - Device time is between 5:00 AM and 12:00 PM
  /// - Morning azkar not completed today
  /// - Notification not shown today
  /// - Notifications are enabled in settings
  Future<void> checkAndNotifyMorningOnLaunch() async {
    if (!_areNotificationsEnabled()) return;
    final now = DateTime.now();
    final hour = now.hour;

    // Check if time is between 5 AM and 12 PM
    if (hour >= 5 && hour < 3) {
      // Check if notification was already shown today
      if (!_wasNotificationShownToday(lastMorningNotifDateKey)) {
        // Check if morning azkar was not completed today
        if (!_isMorningCompletedToday()) {
          await _showInstantNotification(
            id: morningReminderId,
            title: 'أذكار الصباح 🌅',
            body: NotificationMessages.getRandomMorningMessage(),
          );
          _markNotificationShownToday(lastMorningNotifDateKey);
        }
      }
    }
  }

  /// SCENARIO 2: Check and notify for evening azkar on app launch
  /// Conditions:
  /// - Device time is between 3:30 PM and 11:59 PM
  /// - Evening azkar not completed today
  /// - Notification not shown today
  /// - Notifications are enabled in settings
  Future<void> checkAndNotifyEveningOnLaunch() async {
    if (!_areNotificationsEnabled()) return;
    final now = DateTime.now();
    final hour = now.hour;
    final minute = now.minute;

    // Check if time is between 3:30 PM (15:30) and 11:59 PM (23:59)
    final isAfter330PM = (hour > 15) || (hour == 15 && minute >= 30);
    final isBeforeMidnight = hour < 2;

    if (isAfter330PM && isBeforeMidnight) {
      // Check if notification was already shown today
      if (!_wasNotificationShownToday(lastEveningNotifDateKey)) {
        // Check if evening azkar was not completed today
        if (!_isEveningCompletedToday()) {
          await _showInstantNotification(
            id: eveningReminderId,
            title: 'أذكار المساء 🌙',
            body: NotificationMessages.getRandomEveningMessage(),
          );
          _markNotificationShownToday(lastEveningNotifDateKey);
        }
      }
    }
  }

  /// SCENARIO 3: Show notification when app loses focus and azkar is incomplete
  /// Call this when app is minimized or loses focus
  /// - progress > 0 (azkar started)
  /// - progress < 100 (azkar not completed)
  /// - Notifications are enabled in settings
  Future<void> notifyIfIncompleteAzkar({required double progress}) async {
    if (!_areNotificationsEnabled()) return;
    if (progress > 0 && progress < 100) {
      await _showInstantNotification(
        id: incompleteAzkarId,
        title: 'لم تكمل أذكارك 📿',
        body: 'تبقى لك أذكار لم تكملها، عد وأكملها الآن',
      );
    }
  }

  /// Cancel the incomplete azkar notification (call when azkar is completed)
  Future<void> cancelIncompleteAzkarNotification() async {
    try {
      await _flutterLocalNotificationsPlugin.cancel(id: incompleteAzkarId);
    } catch (e) {
      print('Error canceling notification: $e');
    }
  }

  /// Mark morning azkar as completed today
  void markMorningCompletedToday() {
    try {
      final box = Hive.box('azkarBox');
      box.put('morningCompletedDate', _getTodayDate());
    } catch (e) {
      print('Error marking morning as completed: $e');
    }
  }

  /// Mark evening azkar as completed today
  void markEveningCompletedToday() {
    try {
      final box = Hive.box('azkarBox');
      box.put('eveningCompletedDate', _getTodayDate());
    } catch (e) {
      print('Error marking evening as completed: $e');
    }
  }
}
