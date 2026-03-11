import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/components/custom_card.dart';

class AzkarContentCard extends StatelessWidget {
  final String zekrText;
  final String blessText;

  const AzkarContentCard({
    super.key,
    required this.zekrText,
    required this.blessText,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: "$zekrText\n\n",
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontSize: 22.sp,
                fontWeight: FontWeight.w500,
              ),
            ),

            if (blessText.isNotEmpty)
              TextSpan(
                text: blessText,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodySmall?.color,
                  fontSize: 16.sp,
                ),
              ),
          ],
        ),
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.center,
      ),
    );
  }
}
