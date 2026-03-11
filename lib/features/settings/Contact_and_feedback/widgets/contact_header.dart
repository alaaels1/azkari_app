import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';

class ContactHeader extends StatelessWidget {
  const ContactHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Container(
          width: 82.r,
          height: 82.r,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDark
                ? AppColors.darkCardBackground
                : AppColors.zekrCardBackground,
            border: Border.all(
              color: isDark
                  ? AppColors.thirdColor.withOpacity(0.25)
                  : AppColors.secondaryColor.withOpacity(0.15),
              width: 1.5.w,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? AppColors.thirdColor.withOpacity(0.08)
                    : AppColors.secondaryColor.withOpacity(0.08),
                blurRadius: 20.r,
                spreadRadius: 4.r,
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.email_rounded,
              size: 38.r,
              color: isDark ? AppColors.thirdColor : AppColors.secondaryColor,
            ),
          ),
        ),
        SizedBox(height: 18.h),

        // Title
        Text(
          'شاركنا رأيك',
          style: TextStyle(
            fontFamily: 'Alyamama',
            fontSize: 22.sp,
            fontWeight: FontWeight.w800,
            color: isDark ? AppColors.darkTextColor : AppColors.secondaryColor,
          ),
        ),
        SizedBox(height: 8.h),

        // Subtitle
        Text(
          'انسخ أحد الإيميلات وراسلنا بأي استفسار أو اقتراح',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 16.sp,
            height: 1.6,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
