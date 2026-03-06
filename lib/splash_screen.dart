import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../features/home/home_views/home_screen.dart';

class AppSplashScreen {
  static AnimatedSplashScreen build({required bool isLightMode}) {
    return AnimatedSplashScreen(
      backgroundColor: isLightMode
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
    );
  }
}