import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial()) {
    _loadTheme();
  }

  static const String _boxName = 'settings';
  static const String _key = 'isDarkMode';

  void toggleTheme() async {
    final isDark = state.themeMode == ThemeMode.dark;
    final newMode = isDark ? ThemeMode.light : ThemeMode.dark;
    
    var box = await Hive.openBox(_boxName);
    await box.put(_key, !isDark);
    
    emit(ThemeChanged(newMode));
  }

  void _loadTheme() async {
    var box = await Hive.openBox(_boxName);
    final isDark = box.get(_key, defaultValue: false);
    emit(ThemeChanged(isDark ? ThemeMode.dark : ThemeMode.light));
  }
}
