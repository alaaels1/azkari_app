import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeSection extends StatelessWidget {
  final String welcomeText;

  const WelcomeSection({super.key, required this.welcomeText});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: screenWidth * 0.07),
          child: Center(
            child: Text(
              welcomeText,
              textDirection: TextDirection.rtl,
              style: GoogleFonts.tajawal(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : const Color(0xFF0D1B2A),
              ),
            ),
          ),
        ),

        Center(
          child: Text(
            "أي الأذكار ترغب بقراءتها الآن؟",
            textDirection: TextDirection.rtl,
            style: GoogleFonts.tajawal(
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white70 : const Color(0xFF1A2F45),
            ),
          ),
        ),
      ],
    );
  }
}
