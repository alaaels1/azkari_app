import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/components/custom_button.dart';
import '../../../core/constants/app_colors.dart';

class AzkarButtonsRow extends StatelessWidget {
  final VoidCallback onEveningPressed;
  final VoidCallback onMorningPressed;

  const AzkarButtonsRow({
    super.key,
    required this.onEveningPressed,
    required this.onMorningPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: CustomButton(
              text: "أذكار المساء",
              tintColor: AppColors.thirdColor,
              hoverShadowColor: AppColors.thirdColor,
              borderColor: AppColors.thirdColor.withOpacity(0.4),
              textColor: AppColors.secondaryColor,
              fontSize: 28.sp,
              height: 100.h,
              width: 220.w,
              radius: 5.r,
              onPressed: onEveningPressed,
            ),
          ),
          SizedBox(width: 70.w),

          Flexible(
            child: CustomButton(
              text: "أذكار الصباح",
              tintColor: AppColors.accentYellow,
              hoverShadowColor: AppColors.accentYellow,
              borderColor: AppColors.accentYellow.withOpacity(0.4),
              textColor: AppColors.secondaryColor,
              fontSize: 28.sp,
              height: 100.h,
              width: 220.w,
              radius: 5.r,
              onPressed: onMorningPressed,
            ),
          ),
        ],
      ),
    );
  }
}
