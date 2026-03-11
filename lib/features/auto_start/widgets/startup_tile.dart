import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/components/setting_tile.dart';
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
            leading:  Icon(Icons.rocket_launch_rounded,color: Theme.of(context).primaryColor,),
            trailing: state is StartupLoading || state is StartupInitial
                ? const SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
                : Switch(
              value: state is StartupEnabled,
              activeColor: Theme.of(context).primaryColor ,
              onChanged: (value) =>
                  context.read<StartupCubit>().toggle(value),
            ),
          );
        },
      ),
    );
  }
}