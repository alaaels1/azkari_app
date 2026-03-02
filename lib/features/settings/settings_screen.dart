import 'package:azkari_app/core/components/custom_Appbar.dart';
import 'package:azkari_app/core/theme/theme_cubit.dart';
import 'package:azkari_app/core/theme/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'calendar/calendar_view.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final isDarkMode = state.themeMode == ThemeMode.dark;
        return SafeArea(
          child: Scaffold(
            appBar: CustomAppBar(
              icon1: Icons.push_pin_outlined,
              onPressedIcon1: () {},
              icon2: false,
              icon3: Icons.keyboard_arrow_right_rounded,
              onPressedIcon3: () => Navigator.pop(context),
              title: 'الإعدادات',
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: [
                    ListTile(
                      title: const Text(
                        'الوضع الليلي',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: Icon(
                        isDarkMode ? Icons.dark_mode : Icons.light_mode,
                        color: isDarkMode ? Colors.amber : Colors.blue,
                      ),
                      trailing: Switch(
                        value: isDarkMode,
                        onChanged: (value) {
                          context.read<ThemeCubit>().toggleTheme();
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text(
                        'تتبع التقدم',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: Icon(Icons.calendar_month),

                      trailing: IconButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProgressScreen(),
                          ),
                        ),
                        icon: Icon(Icons.chevron_right),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
