import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomeSection extends StatelessWidget {
  final String welcomeText;

  const WelcomeSection({super.key, required this.welcomeText});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _dot(0.3, color),
              _line(color),
              _dot(0.6, color),
              _line(color),
              _dot(1.0, color),
              _line(color),
              _dot(0.6, color),
              _line(color),
              _dot(0.3, color),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            welcomeText,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: GoogleFonts.tajawal(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              height: 1.7,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _dot(0.3, color),
              _line(color),
              _dot(0.6, color),
              _line(color),
              _dot(1.0, color),
              _line(color),
              _dot(0.6, color),
              _line(color),
              _dot(0.3, color),
            ],
          ),
          SizedBox(height: 50.h),
          Text(
            "أي الأذكار ترغب بقراءتها الآن؟",
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
            style: GoogleFonts.tajawal(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3.w,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(double opacity, Color color) => Container(
        width: 5.r,
        height: 5.r,
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(opacity),
        ),
      );

  Widget _line(Color color) => Container(
        width: 18.w,
        height: 1.5.h,
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        color: color.withOpacity(0.25),
      );
}
