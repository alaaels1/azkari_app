import 'package:azkari_app/core/constants/app_colors.dart';
import 'package:azkari_app/features/settings/widgets/delete_data_dialog.dart';
import 'package:azkari_app/features/settings/widgets/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/components/custom_Appbar.dart';
import '../theme/theme_cubit.dart';
import '../theme/theme_state.dart';
import 'calendar/progress_screen.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final isDarkMode = state.themeMode == ThemeMode.dark;

        return SafeArea(
          child: Scaffold(
            appBar: CustomAppBar(
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

                    SettingTile(
                      title: 'الوضع الليلي',
                      leading: Icon(
                        isDarkMode ? Icons.dark_mode : Icons.light_mode,
                        color: isDarkMode ? Colors.amber : Colors.blue,
                      ),
                      trailing: Switch(
                        value: isDarkMode,
                        activeColor:AppColors.thirdColor,
                        onChanged: (_) =>
                            context.read<ThemeCubit>().toggleTheme(),
                      ),
                    ),

                    const Divider(),

                    SettingTile(
                      title: 'تتبع التقدم',
                      leading: Icon(
                        Icons.date_range,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      trailing: IconButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProgressScreen(),
                          ),
                        ),
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ),

                    const Divider(),

                    SettingTile(
                      title: 'حذف بياناتك',
                      leading: const Icon(Icons.delete, color: Colors.red),
                      trailing: IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: () => DeleteDataDialog.show(context),
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