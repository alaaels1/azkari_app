import 'package:azkari_app/core/constants/app_colors.dart';
import 'package:azkari_app/features/settings/widgets/delete_data_dialog.dart';
import 'package:azkari_app/features/settings/widgets/setting_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:iconify_flutter/icons/material_symbols.dart';
import '../../../core/components/custom_Appbar.dart';
import '../auto_start/widgets/startup_widget.dart';
import '../theme/theme_cubit.dart';
import '../theme/theme_state.dart';
import 'Contact_and_feedback/Contact_and_feedback_screen.dart';
import 'calendar/progress_screen.dart';
import 'privacy_policy/privacy_policy_screen.dart';
import 'package:colorful_iconify_flutter/icons/flat_color_icons.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late bool _notificationsEnabled;

  @override
  void initState() {
    super.initState();
    _loadNotificationPreference();
  }

  Future<void> _loadNotificationPreference() async {
    final box = Hive.box('azkarBox');
    final enabled = box.get('notificationsEnabled', defaultValue: true) as bool;
    setState(() {
      _notificationsEnabled = enabled;
    });
  }

  Future<void> _saveNotificationPreference(bool enabled) async {
    final box = Hive.box('azkarBox');
    await box.put('notificationsEnabled', enabled);
  }

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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SettingTile(
                        title: 'الوضع الليلي',
                        leading: Icon(
                          isDarkMode ? Icons.dark_mode : Icons.light_mode,
                          color: isDarkMode ? Colors.amber : Colors.blue[900],
                        ),
                        trailing: Switch(
                          value: isDarkMode,
                          activeColor: AppColors.thirdColor,
                          onChanged: (_) =>
                              context.read<ThemeCubit>().toggleTheme(),
                        ),
                      ),

                      const Divider(),

                      SettingTile(
                        title: 'التنبيهات',
                        leading: Icon(
                          _notificationsEnabled
                              ? Icons.notifications_active
                              : Icons.notifications_off,
                          color: _notificationsEnabled
                              ? AppColors.thirdColor
                              : Colors.grey,
                        ),
                        trailing: Switch(
                          value: _notificationsEnabled,
                          activeColor: AppColors.thirdColor,
                          onChanged: (value) {
                            setState(() {
                              _notificationsEnabled = value;
                            });
                            _saveNotificationPreference(value);
                          },
                        ),
                      ),

                      const Divider(),
                      StartupSwitchTile(),
                      const Divider(),

                      SettingTile(
                        title: 'تتبع التقدم',
                        leading: Iconify(FlatColorIcons.calendar),
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
                        title: 'تواصل معنا',
                        leading: const Iconify(
                          MaterialSymbols.mail,
                          color: AppColors.secondaryColor,
                        ),
                        trailing: IconButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ContactAndFeedbackScreen(),
                            ),
                          ),
                          icon: const Icon(Icons.chevron_right),
                        ),
                      ),

                      const Divider(),

                      SettingTile(
                        title: 'سياسة الخصوصية',
                        leading: const Iconify(
                          MaterialSymbols.privacy_tip,
                          color: AppColors.secondaryColor,
                        ),
                        trailing: IconButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const PrivacyPolicyScreen(),
                            ),
                          ),
                          icon: const Icon(Icons.chevron_right),
                        ),
                      ),

                      const Divider(),
                      SettingTile(
                        title: 'حذف بياناتك',
                        leading: const Iconify(
                          Bi.trash3_fill,
                          color: Colors.red,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.chevron_right),
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
