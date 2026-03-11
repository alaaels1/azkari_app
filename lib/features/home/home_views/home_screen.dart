import 'dart:math';
import 'package:azkari_app/core/components/custom_appbar.dart';
import 'package:azkari_app/features/azkar/AzkaraMassaView/azkar_massa_view.dart';
import 'package:azkari_app/features/azkar/AzkarSabahView/azkar_sabah_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/enum.dart';
import '../../azkar/cubits/azkar_cubit.dart';
import '../../settings/settings_screen.dart';
import '../../update/update_dialog.dart';
import '../home_widgets/azkar_button_row.dart';
import '../home_widgets/hijri_date_widget.dart';
import '../home_widgets/welcome_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final random = Random();
  late final String welcomeText;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) checkAndShowUpdate(context);
    });
    welcomeText = MainStrings
        .welcomeMessages[random.nextInt(MainStrings.welcomeMessages.length)];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          icon2: true,
          icon3: Icons.settings,
          onPressedIcon3: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SettingScreen()),
          ),
          title: "أذكـاري",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                SizedBox(height: 40.h),
                WelcomeSection(welcomeText: welcomeText),
                AzkarButtonsRow(
                  onEveningPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) =>
                            AzkarCubit()..loadAzkar(ZekrType.evening),
                        child: const AzkarMassaView(),
                      ),
                    ),
                  ),

                  onMorningPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) =>
                            AzkarCubit()..loadAzkar(ZekrType.morning),
                        child: const AzkarSabahView(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 40.h),
                const HijriDateWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
