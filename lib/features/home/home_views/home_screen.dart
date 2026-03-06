import 'dart:math';
import 'package:azkari_app/core/components/custom_Appbar.dart';
import 'package:azkari_app/features/azkar/AzkaraMassaView/azkar_massa_view.dart';
import 'package:azkari_app/features/azkar/AzkarSabahView/azkar_sabah_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/utils/enum.dart';
import '../../azkar/cubits/azkar_cubit.dart';
import '../../settings/settings_screen.dart';
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
          title: "أذكاري",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                WelcomeSection(welcomeText: welcomeText),
                AzkarButtonsRow(
                  onEveningPressed: ()=> Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) =>
                        AzkarCubit()..loadAzkar(ZekrType.evening),
                        child: const AzkarMassaView(),
                      ),
                    ),                ),
      
                  onMorningPressed: ()  => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) =>
                        AzkarCubit()..loadAzkar(ZekrType.morning),
                        child: const AzkarSabahView(),
                      ),
                    ),                ),
                ),
                HijriDateWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
