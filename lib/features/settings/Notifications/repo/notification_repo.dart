import '../../../../core/main_repo/main_repo.dart';

class NotificationRepository extends MainRepository {
  // ── Keys ──────────────────────────────────────────
  static const String morningCompletedKey  = 'morningCompletedDate';
  static const String eveningCompletedKey  = 'eveningCompletedDate';
  static const String morningNotifCountKey = 'morningNotifCount';
  static const String morningLastTimeKey   = 'morningLastNotifTime';
  static const String eveningNotifCountKey = 'eveningNotifCount';
  static const String eveningLastTimeKey   = 'eveningLastNotifTime';

  static const String incompleteLastTimeKey      = 'incompleteLastNotifTime';
  static const String incompleteReminderCountKey = 'incompleteReminderCount';
  static const String incompleteReminderDateKey  = 'incompleteReminderDate';

  // ── Today ─────────────────────────────────────────
  String get todayDate {
    final now = DateTime.now();
    return '${now.year}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';
  }

  // ── Enabled ───────────────────────────────────────
  bool get notificationsEnabled =>
      box.get('notificationsEnabled', defaultValue: true) as bool;

  Future<void> setNotificationsEnabled(bool value) =>
      box.put('notificationsEnabled', value);

  // ── Completed ─────────────────────────────────────
  bool get isMorningCompleted => box.get(morningCompletedKey) == todayDate;
  bool get isEveningCompleted => box.get(eveningCompletedKey) == todayDate;

  void markMorningCompleted() => box.put(morningCompletedKey, todayDate);
  void markEveningCompleted() => box.put(eveningCompletedKey, todayDate);

  // ── Count ─────────────────────────────────────────
  int getNotifCountToday(String countKey) {
    final storedDate = box.get('${countKey}_date') as String?;
    if (storedDate != todayDate) {
      box.delete(countKey);
      return 0;
    }
    return box.get(countKey, defaultValue: 0) as int;
  }

  void incrementNotifCount(String countKey) {
    final current = getNotifCountToday(countKey);
    box.put(countKey, current + 1);
    box.put('${countKey}_date', todayDate);
  }

  // ── Time Gap ──────────────────────────────────────
  bool isEnoughTimePassed(String lastTimeKey, int minGapMinutes) {
    final lastTimeStr = box.get(lastTimeKey) as String?;
    if (lastTimeStr == null) return true;

    try {
      final diff = DateTime.now()
          .difference(DateTime.parse(lastTimeStr))
          .inMinutes;
      return diff >= minGapMinutes;
    } catch (e) {
      return true;
    }
  }

  void saveLastNotifTime(String lastTimeKey) =>
      box.put(lastTimeKey, DateTime.now().toIso8601String());

  // ── Incomplete Reminder Count ─────────────────────
  int getIncompleteReminderCount() {
    final storedDate = box.get(incompleteReminderDateKey) as String?;

    if (storedDate != todayDate) {
      box.delete(incompleteReminderCountKey);
      return 0;
    }

    return box.get(incompleteReminderCountKey, defaultValue: 0) as int;
  }

  void incrementIncompleteReminderCount() {
    final current = getIncompleteReminderCount();
    box.put(incompleteReminderCountKey, current + 1);
    box.put(incompleteReminderDateKey, todayDate);
  }

  void resetIncompleteReminderCount() {
    box.delete(incompleteReminderCountKey);
    box.delete(incompleteReminderDateKey);
    box.delete(incompleteLastTimeKey);
  }
}
