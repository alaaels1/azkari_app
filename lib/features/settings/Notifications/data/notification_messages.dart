/// Motivational messages for daily azkar reminders
class NotificationMessages {
  static const List<String> morningMessages = [
    "ابدأ يومك بذكر الله وأنت في أحسن حال 🌅",
    "الأذكار درع يومك، لا تنطلق بدونه 🛡️",
    "دقائق معدودة تملأ يومك بالبركة ✨",
    "ذكر الله في الصباح نور يضيء يومك كله 🌟",
    "أذكار الصباح.. طاقة يومك الحقيقية 💪",
  ];

  static const List<String> eveningMessages = [
    "اختم نهارك بذكر الله قبل أن ينتهي النهار 🌙",
    "أذكار المساء حصنك في الليل 🌃",
    "لا تنم قبل أن تحصن نفسك بأذكار المساء 🌠",
    "دقائق قبل الغروب تستحق كل لحظة 🌅",
    "اجعل آخر عملك ذكر الله 📿",
  ];

  /// Get a random morning message
  static String getRandomMorningMessage() {
    return morningMessages[DateTime.now().millisecond % morningMessages.length];
  }

  /// Get a random evening message
  static String getRandomEveningMessage() {
    return eveningMessages[DateTime.now().millisecond % eveningMessages.length];
  }
}
