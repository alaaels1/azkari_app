import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../features/settings/calendar/progress_screen.dart';

void showCompletionDialog(BuildContext context, String azkarType) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: "Completion Dialog",
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) {
      return Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child:  Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 50.sp,
                  ),
                ),

                const SizedBox(height: 20),

                 Text(
                  "👏أحسنت",
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                 SizedBox(height: 12.h),

                Text(
                  "أكملت $azkarType",
                  style:  TextStyle(fontSize: 18.sp),
                ),

                 SizedBox(height: 8.sp),

                 Text(
                  "🤲 جعله الله في ميزان حسناتك ",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey,
                  ),
                ),

                 SizedBox(height: 24.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child:  Text("الرئيسية" , style: TextStyle(color: Theme.of(context).primaryColor),),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding:  EdgeInsets.symmetric(
                          horizontal: 24.h,
                          vertical: 12.w,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProgressScreen(),
                          ),
                        );

                      },
                      child: const Text(
                        "متابعة التقدم 📊",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return ScaleTransition(
        scale: CurvedAnimation(
          parent: anim1,
          curve: Curves.easeOutBack,
        ),
        child: child,
      );
    },
  );
}