import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeSection extends StatelessWidget {
  final String welcomeText;

  const WelcomeSection({super.key, required this.welcomeText});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

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
                color: Theme.of(context).textTheme.bodyLarge?.color,              ),
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
              color: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.color
                  ?.withOpacity(0.8),            ),
          ),
        ),
      ],
    );
  }
}
