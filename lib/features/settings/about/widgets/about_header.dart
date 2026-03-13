import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AboutHeader extends StatelessWidget {
  const AboutHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "أذكاري",
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.cairo(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                ),
                FutureBuilder(
                  future: PackageInfo.fromPlatform(),
                  builder: (_, snapshot) => Text(
                    '  رقم الإصدار ${snapshot.data?.version ?? ''}',
                    style: GoogleFonts.cairo(color: Colors.grey, fontSize: 13.sp),
                  ),
                ),
              ],
            ),
            SizedBox(width: 12.w),
            Image.asset("assets/photos/Logo.png", height: 50.h),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          "أقدّم هذا العمل صدقةً جارية لوجه الله، وأسأل الله أن ينفع به.",
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(
            fontSize: 16.sp,
            height: 1.7,
            color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}