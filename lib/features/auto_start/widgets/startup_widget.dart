import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import '../../settings/widgets/setting_tile.dart';
import '../../../core/constants/app_colors.dart';
import 'package:colorful_iconify_flutter/icons/noto.dart';
import '../cubit/startup_cubit.dart';

class StartupSwitchTile extends StatelessWidget {
  const StartupSwitchTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StartupCubit()..loadStatus(),
      child: BlocBuilder<StartupCubit, StartupState>(
        builder: (context, state) {
          return SettingTile(
            title: 'فتح تطبيق أذكاري تلقائيًا عند تشغيل الجهاز',
            leading: const Iconify(Noto.rocket),
            trailing: state is StartupLoading || state is StartupInitial
                ? const SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
                : Switch(
              value: state is StartupEnabled,
              activeColor: AppColors.footerColor,
              onChanged: (value) =>
                  context.read<StartupCubit>().toggle(value),
            ),
          );
        },
      ),
    );
  }
}