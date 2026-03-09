import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/constants/app_colors.dart';

class ContactEmailCard extends StatelessWidget {
  final String label;
  final String email;

  const ContactEmailCard({
    super.key,
    required this.label,
    required this.email,
  });

  void _copyEmail(BuildContext context) {
    Clipboard.setData(ClipboardData(text: email));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'تم نسخ: $email',
          textDirection: TextDirection.rtl,
          style: const TextStyle(fontFamily: 'Cairo', fontSize: 13),
        ),
        backgroundColor: AppColors.secondaryColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBackground : AppColors.zekrCardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark
              ? AppColors.thirdColor.withOpacity(0.15)
              : AppColors.secondaryColor.withOpacity(0.12),
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.25)
                : AppColors.secondaryColor.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Mail icon container
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.thirdColor.withOpacity(0.12)
                  : AppColors.secondaryColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.mail_outline_rounded,
              size: 22,
              color: isDark ? AppColors.thirdColor : AppColors.secondaryColor,
            ),
          ),
          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 11,
                    color: isDark ? AppColors.footerColor : AppColors.footerColor,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                    color: isDark ? AppColors.darkTextColor : AppColors.secondaryColor,
                  ),
                ),
              ],
            ),
          ),

          // Copy button
          Tooltip(
            message: 'نسخ',
            child: InkWell(
              onTap: () => _copyEmail(context),
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.copy_rounded,
                  size: 18,
                  color: isDark ? AppColors.thirdColor : AppColors.footerColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
