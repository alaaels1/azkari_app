import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ContactHeader extends StatelessWidget {
  const ContactHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Container(
          width: 82,
          height: 82,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isDark
                ? AppColors.darkCardBackground
                : AppColors.zekrCardBackground,
            border: Border.all(
              color: isDark
                  ? AppColors.thirdColor.withOpacity(0.25)
                  : AppColors.secondaryColor.withOpacity(0.15),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? AppColors.thirdColor.withOpacity(0.08)
                    : AppColors.secondaryColor.withOpacity(0.08),
                blurRadius: 20,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.email_rounded,
                  size: 38,
                  color: isDark ? AppColors.thirdColor : AppColors.secondaryColor,
                ),

              ],
            ),
          ),
        ),
        const SizedBox(height: 18),

        // Title
        Text(
          'تواصل معنا',
          style: TextStyle(
            fontFamily: 'Nasrat',
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: isDark ? AppColors.darkTextColor : AppColors.secondaryColor,
          ),
        ),
        const SizedBox(height: 8),

        // Subtitle
        Text(
          'انسخ أحد الإيميلات وراسلنا بأي استفسار أو اقتراح',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 13,
            height: 1.6,
            color: AppColors.footerColor,
          ),
        ),
      ],
    );
  }
}
