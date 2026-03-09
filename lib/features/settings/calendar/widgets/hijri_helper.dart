import 'package:hijri_date/hijri_date.dart';

class HijriHelper {
  static const List<String> _arabicMonths = [
    'محرم',
    'صفر',
    'ربيع الأول',
    'ربيع الآخر',
    'جمادى الأولى',
    'جمادى الآخرة',
    'رجب',
    'شعبان',
    'رمضان',
    'شوال',
    'ذو القعدة',
    'ذو الحجة',
  ];

  /// Applies the user-defined offset before converting to Hijri
  static DateTime _applyOffset(DateTime date, int offset) =>
      date.add(Duration(days: offset));

  static String formatHijri(DateTime date, {int offset = 0}) {
    final hijri = HijriDate.fromDate(_applyOffset(date, offset));
    final String monthName = _arabicMonths[hijri.hMonth - 1];
    return "$monthName ${_toArabicNumbers(hijri.hYear.toString())} هـ";
  }

  static String getHijriDay(DateTime date, {int offset = 0}) {
    final hijri = HijriDate.fromDate(_applyOffset(date, offset));
    return _toArabicNumbers(hijri.hDay.toString());
  }

  static String fullHijri(DateTime date, {int offset = 0}) {
    final h = HijriDate.fromDate(_applyOffset(date, offset));

    const days = [
      'السبت',
      'الأحد',
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
    ];

    final dayName = days[h.weekDay() - 1];
    final monthName = _arabicMonths[h.hMonth - 1];

    return "$dayName ${_toArabicNumbers(h.hDay.toString())} "
        "$monthName ${_toArabicNumbers(h.hYear.toString())} هـ";
  }

  static String shortHijri(DateTime date, {int offset = 0}) {
    final h = HijriDate.fromDate(_applyOffset(date, offset));
    final month = _arabicMonths[h.hMonth - 1];
    return "${_toArabicNumbers(h.hDay.toString())} $month";
  }

  static String dual(DateTime date, {int offset = 0}) {
    final h = HijriDate.fromDate(_applyOffset(date, offset));
    final month = _arabicMonths[h.hMonth - 1];

    final hijriPart = "${_toArabicNumbers(h.hDay.toString())} "
        "$month "
        "${_toArabicNumbers(h.hYear.toString())} هـ";

    final gregorianPart = "${date.day}/${date.month}/${date.year}";

    return "$hijriPart | $gregorianPart";
  }

  static String _toArabicNumbers(String input) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    for (int i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], arabic[i]);
    }
    return input;
  }
}