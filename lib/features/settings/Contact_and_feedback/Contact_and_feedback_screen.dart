import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/components/custom_appbar.dart';
import 'widgets/contact_email_card.dart';
import 'widgets/contact_header.dart';


class ContactAndFeedbackScreen extends StatelessWidget {
  const ContactAndFeedbackScreen({super.key});

  static const String _email1 = 'azkariapp2026@gmail.com';
  static const String _email2 = 'alaa.elsaidy.dev@gmail.com';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          icon2: false,
          icon3: Icons.keyboard_arrow_right_rounded,
          onPressedIcon3: () => Navigator.pop(context),
          title: 'اتصل بنا',
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500.w),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const ContactHeader(),
                    SizedBox(height: 36.h),

                    ContactEmailCard(
                      label: 'البريد الرسمي للتطبيق',
                      email: _email1,
                    ),
                    SizedBox(height: 12.h),

                    ContactEmailCard(
                      label: 'المطوّر',
                      email: _email2,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
