import 'package:azkari_app/features/settings/calendar/widgets/hijri_offset_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../settings/calendar/widgets/hijri_helper.dart';

class HijriDateWidget extends StatelessWidget {
  const HijriDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final offset = context.read<HijriOffsetRepository>().getOffset();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.thirdColor.withOpacity(0.08)
            : AppColors.thirdColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calendar_today_rounded,
              size: 18.r,
              color: isDark ? AppColors.thirdColor : AppColors.footerColor,
            ),
            SizedBox(width: 8.w),
            Text(
              HijriHelper.dual(DateTime.now(), offset: offset),
              textDirection: TextDirection.rtl,
              style: GoogleFonts.cairo(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppColors.thirdColor.withOpacity(0.85)
                    : AppColors.footerColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
