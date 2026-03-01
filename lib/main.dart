import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:azkari_app/core/theme/theme_cubit.dart';
import 'package:azkari_app/core/theme/theme_state.dart';
import 'package:azkari_app/features/home/home_views/home_screen.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  runApp(
    BlocProvider(
      create: (context) => ThemeCubit(),
      child: const MyApp(),
    ),
  );
  
  appWindow.size = const Size(700, 600);
  appWindow.show();
  doWhenWindowReady(() {
    const maxsize = Size(700, 600);
    const minsize = Size(500, 400);

    appWindow.minSize = minsize;
    appWindow.maxSize = maxsize;
    appWindow.alignment = Alignment.center;
    appWindow.title = "Custom window with Flutter";
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: state.themeMode,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: const Color(0xFFF2F2F2),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: const Color(0xFF0B132B),
          ),
          home: AnimatedSplashScreen(
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
