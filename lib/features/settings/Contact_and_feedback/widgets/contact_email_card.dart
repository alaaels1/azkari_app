import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';

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
          style: TextStyle(fontFamily: 'Cairo', fontSize: 13.sp),
        ),
        backgroundColor: AppColors.secondaryColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.r),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCardBackground : AppColors.zekrCardBackground,
        borderRadius: BorderRadius.circular(16.r),
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
            blurRadius: 10.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Row(
        children: [
          // Mail icon container
          Container(
            width: 42.r,
            height: 42.r,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.thirdColor.withOpacity(0.12)
                  : AppColors.secondaryColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.mail_outline_rounded,
              size: 22.r,
              color: isDark ? AppColors.thirdColor : AppColors.secondaryColor,
            ),
          ),
          SizedBox(width: 14.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize:16.sp,
                    color: AppColors.footerColor,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  email,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2.w,
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
              borderRadius: BorderRadius.circular(10.r),
              child: Padding(
                padding: EdgeInsets.all(8.r),
                child: Icon(
                  Icons.copy_rounded,
                  size: 22.r,
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
