import 'package:azkari_app/core/components/custom_info_card.dart';
import 'package:azkari_app/features/settings/about/widgets/about_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/components/custom_appbar.dart';
import 'data/about_data.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  void _openLink(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "عن التطبيق",
          icon2: false,
          icon3: Icons.keyboard_arrow_right_rounded,
          onPressedIcon3: () => Navigator.pop(context),
        ),
        body: ListView(
          padding: EdgeInsets.all(20.r),
          children: [
            const AboutHeader(),
            SizedBox(height: 24.h),
            ...aboutSections.map((section) => CustomInfoCard(
              section: section,
              trailing: section == aboutSections.last
                  ? GestureDetector(
                onTap: () => _openLink(githubUrl),
                child: Text(
                  "Source Code (GitHub)",

                  textDirection: TextDirection.ltr,
                  style: GoogleFonts.cairo(
                    fontSize: 15,
                    color: primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              )
                  : null,
            )),
          ],
        ),
      ),
    );
  }
}