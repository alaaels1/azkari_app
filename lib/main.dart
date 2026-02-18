import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:azkari_app/presentation/screens/home/home_screen.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: CircleAvatar(
          radius: 132,
          backgroundImage: AssetImage("lib/assets/photos/Logo.png"),
          backgroundColor: Colors.transparent,
        ),
        splashIconSize: 200,
        splashTransition: SplashTransition.fadeTransition,
        nextScreen: const HomeScreen(),
      ),
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
