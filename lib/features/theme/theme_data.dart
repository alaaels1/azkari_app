import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class AppTheme {

  ///Light Theme
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.secondaryColor,
    scaffoldBackgroundColor: AppColors.backgroundLightMode,

    /// App Bar
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

    /// Card
    cardColor: AppColors.zekrCardBackground,
    /// Icon
    iconTheme: const IconThemeData(color: AppColors.secondaryColor),
    ///Text
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.secondaryColor),
      bodyMedium: TextStyle(color: AppColors.secondaryColor),
      bodySmall: TextStyle(color: AppColors.footerColor),
    ),
  );

  ///Dark Theme
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.backgroundDarkMode,
    primaryColor: AppColors.thirdColor,
    cardColor: AppColors.darkCardBackground,

    /// App Bar
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.appBarBackground2,
      elevation: 0,
      iconTheme: IconThemeData(color: AppColors.darkTextColor),
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.darkTextColor,
        fontSize: 24,
        fontWeight: FontWeight.w800,
        fontFamily: "Nasrat",
      ),
    ),

    /// Icon
    iconTheme: const IconThemeData(color: AppColors.darkTextColor),

    ///Text Theme
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkTextColor),
      bodyMedium: TextStyle(color: AppColors.darkTextColor),
      bodySmall: TextStyle(color: AppColors.darkTextColor),
    ),
  );
}