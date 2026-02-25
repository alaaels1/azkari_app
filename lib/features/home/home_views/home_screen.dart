import 'dart:math';
import 'package:azkari_app/core/components/custom_Appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hijri/hijri_calendar.dart';
import '../../../core/components/custom_button.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Random random = Random();
  late String welcomeText;
  @override
  void initState() {
    welcomeText =
        mainStrings().welcomeMessages[Random().nextInt(
          mainStrings().welcomeMessages.length,
        )];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    HijriCalendar.setLocal("ar");
    final _hijri = HijriCalendar.now();

    return Scaffold(
      backgroundColor: AppColors.backgroundLightMode,
      appBar: CustomAppBar(
        icon1: Icons.push_pin_outlined,
        onPressedIcon1: () {},
        icon2: Icons.dark_mode_outlined,
        onPressedIcon2: () {},
        icon3: Icons.settings,
        onPressedIcon3: () {},
        title: "أذكاري",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: screenWidth * 0.07),
              child: Center(
                child: Text(
                  welcomeText,
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.tajawal(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                    color: AppColors.basicColor,
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                "أي الأذكار ترغب بقراءتها الآن؟",
                textDirection: TextDirection.rtl,
                style: GoogleFonts.tajawal(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    text: "أذكار المساء",
                    color: AppColors.thirdColor,
                    hoverColor: AppColors.basicColor, // اختاري اللي يعجبك
                    textColor: AppColors.secondaryColor,
                    fontSize: screenWidth * 0.04,
                    height: screenHeight * 0.17,
                    width: screenWidth * 0.34,
                    radius: 5,
                    borderWidth: 0,
                    borderColor: Colors.transparent,
                    onPressed: () {},
                    hoverTextColor: AppColors.thirdColor,
                  ),
                  SizedBox(width: screenHeight * 0.2),
                  CustomButton(
                    text: "أذكار الصباح",
                    color: AppColors.thirdColor,
                    hoverColor: AppColors.accentYellow,
                    textColor: AppColors.secondaryColor,
                    fontSize: screenWidth * 0.04,
                    height: screenHeight * 0.17,
                    width: screenWidth * 0.34,
                    radius: 5,
                    borderWidth: 0,
                    borderColor: Colors.transparent,
                    onPressed: () {},
                    hoverTextColor: AppColors.secondaryColor,
                  ),
                ],
              ),
            ),
            RichText(
              textDirection: TextDirection.rtl,
              text: TextSpan(
                style: GoogleFonts.cairo(
                  fontSize: screenWidth * 0.03,
                  fontWeight: FontWeight.w500,
                  color: AppColors.settingIconsColor,
                ),
                children: [
                  TextSpan(text: '${_hijri.dayWeName}, '),
                  TextSpan(text: '${_hijri.hDay} '),
                  TextSpan(text: '${_hijri.longMonthName} '),
                  TextSpan(text: '${_hijri.hYear}هـ'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
