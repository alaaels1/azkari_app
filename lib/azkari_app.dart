import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/app_colors.dart';
import 'core/theme/theme_cubit.dart';
import 'core/theme/theme_state.dart';
import 'features/home/home_views/home_screen.dart';

class AzkariApp extends StatelessWidget {
  const AzkariApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: state.themeMode,

          theme: ThemeData(
            brightness: Brightness.light,

            scaffoldBackgroundColor: AppColors.backgroundLightMode,

            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.appBarBackground2,
              elevation: 0,
              iconTheme: IconThemeData(color: AppColors.secondaryColor),
              titleTextStyle: TextStyle(
                color: AppColors.secondaryColor,
                fontSize: 24,
                fontWeight: FontWeight.w800,
                fontFamily: "Nasrat",
              ),
            ),

            cardColor: AppColors.zekrCardBackground,

            iconTheme: const IconThemeData(color: AppColors.secondaryColor),

            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: AppColors.secondaryColor),
              bodyMedium: TextStyle(color: AppColors.secondaryColor),
              bodySmall: TextStyle(color: AppColors.footerColor),
            ),
          ),

          darkTheme: ThemeData(
            brightness: Brightness.dark,

            scaffoldBackgroundColor: AppColors.backgroundDarkMode,
            cardTheme: CardThemeData(
              color: state.themeMode == ThemeMode.light
                  ? AppColors.appBarBackground2
                  : AppColors.darkCardBackground,
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: state.themeMode == ThemeMode.light
                  ? AppColors.basicColor
                  : AppColors.appBarBackground2,
              elevation: 0,
              iconTheme: const IconThemeData(color: AppColors.darkTextColor),
              centerTitle: true,
              titleTextStyle: const TextStyle(
                color: AppColors.darkTextColor,
                fontSize: 24,
                fontWeight: FontWeight.w800,
                fontFamily: "Nasrat",
              ),
            ),

            cardColor: AppColors.darkCardBackground,

            iconTheme: const IconThemeData(color: AppColors.darkTextColor),

            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: AppColors.darkTextColor),
              bodyMedium: TextStyle(color: AppColors.darkTextColor),
              bodySmall: TextStyle(color: AppColors.darkTextColor),
            ),
          ),

          home: AnimatedSplashScreen(
            backgroundColor: state.themeMode == ThemeMode.light
                ? AppColors.backgroundLightMode
                : AppColors.backgroundDarkMode,
            splash: const CircleAvatar(
              radius: 132,
              backgroundImage: AssetImage("lib/assets/photos/Logo.png"),
              backgroundColor: Colors.transparent,
            ),
            splashIconSize: 200,
            splashTransition: SplashTransition.fadeTransition,
            nextScreen: const HomeScreen(),
          ),
        );
      },
    );
  }
}
