import 'package:azkari_app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/theme/theme_cubit.dart';
import 'features/theme/theme_data.dart';
import 'features/theme/theme_state.dart';


class AzkariApp extends StatelessWidget {
  const AzkariApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(700, 600),
      minTextAdapt: true,
      builder: (_, __) => BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          final isLightMode = state.themeMode == ThemeMode.light;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: state.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: AppSplashScreen.build(isLightMode: isLightMode),
          );
        },
      ),
    );
  }
}