import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';

class HijriDateWidget extends StatelessWidget {
  const HijriDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    HijriCalendar.setLocal('ar');
    final hijri = HijriCalendar.now();

    return RichText(
      textDirection: TextDirection.rtl,
      text: TextSpan(
        style: GoogleFonts.cairo(
        fontSize: screenWidth * 0.03,
        fontWeight: FontWeight.w500,
        color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
      ),
        children: [
          TextSpan(text: '${hijri.dayWeName}, '),
          TextSpan(text: '${hijri.hDay} '),
          TextSpan(text: '${hijri.longMonthName} '),
          TextSpan(text: '${hijri.hYear}هـ'),
        ],
      ),
    );
  }
}
