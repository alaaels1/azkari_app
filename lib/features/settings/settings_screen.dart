import 'package:azkari_app/core/constants/app_colors.dart';
import 'package:azkari_app/features/settings/privacy_policy/widgets/privacy_tile.dart';
import 'package:azkari_app/core/utils/delete_data_dialog.dart';
import 'package:azkari_app/core/components/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/components/custom_appbar.dart';
import '../auto_start/widgets/startup_tile.dart';
import '../theme/theme_cubit.dart';
import '../theme/theme_state.dart';
import 'Contact_and_feedback/widgets/contact_tile.dart';
import 'Notifications/widgets/notification_tile.dart';
import 'about/widgets/about_tile.dart';
import 'calendar/progress_screen.dart';

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
              icon2: false,
              icon3: Icons.keyboard_arrow_right_rounded,
              onPressedIcon3: () => Navigator.pop(context),
              title: 'الإعدادات',
            ),
            body: Padding(
              padding: EdgeInsets.all(16.r),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SettingTile(
                        title: 'الوضع الليلي',
                        leading: Icon(
                          isDarkMode ? Icons.dark_mode : Icons.sunny,
                          color: isDarkMode ? AppColors.accentYellow : AppColors.secondaryColor,
                          size: 24.r,
                        ),
                        trailing: Switch(
                          value: isDarkMode,
                          activeThumbColor: Theme.of(context).primaryColor,
                          onChanged: (_) =>
                              context.read<ThemeCubit>().toggleTheme(),
                        ),
                      ),
                      const Divider(),
                      const NotificationTile(),
                      const Divider(),
                      const StartupSwitchTile(),
                      const Divider(),
                      SettingTile(
                        title: 'تتبع التقدم',
                        leading: Icon(
                          Icons.calendar_month,
                          color: Theme.of(context).primaryColor,
                          size: 24.r,
                        ),
                        trailing: IconButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ProgressScreen(),
                            ),
                          ),
                          icon: Icon(Icons.chevron_right, size: 24.r),
                        ),
                      ),
                      const Divider(),
                      const PrivacyTile(),
                      const Divider(),
                      AboutTile(),
                      const Divider(),
                      const ContactAndFeedbackTile(),
                      const Divider(),
                      SettingTile(
                        title: 'حذف بياناتك',
                        leading: Icon(Icons.delete, color: Colors.red, size: 24.r),
                        trailing: IconButton(
                          icon: Icon(Icons.chevron_right, size: 24.r),
                          onPressed: () => DeleteDataDialog.show(context),
                        ),
                      ),
                      const Divider(),

                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
