import 'package:flutter/material.dart';
import '../../../core/components/custom_Appbar.dart';
import 'contact_email_card.dart';
import 'contact_header.dart';


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
          title: 'تواصل معنا',
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const ContactHeader(),
                    const SizedBox(height: 36),

                    ContactEmailCard(
                      label: 'البريد الرسمي للتطبيق',
                      email: _email1,
                    ),
                    const SizedBox(height: 12),

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
