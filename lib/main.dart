import 'dart:io';
import 'package:azkari_app/features/settings/calendar/widgets/hijri_offset_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:window_manager/window_manager.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'azkari_app.dart';
import 'features/settings/Notifications/logic/app_lifecycle_provider.dart';
import 'features/always_on_top/always_on_top_cubit.dart';
import 'features/counter/data/counter_repository.dart';
import 'features/settings/Notifications/logic/notification_service.dart';
import 'features/settings/Notifications/logic/window_lifecycle_manager.dart';
import 'features/settings/calendar/data/progress_repository.dart';
import 'features/settings/calendar/data/stats_repository.dart';
import 'features/theme/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar', null);
  await Hive.initFlutter();
  await Hive.openBox('azkarBox');

  await windowManager.ensureInitialized();

  await NotificationService().initialize();

  final windowLifecycleManager = WindowLifecycleManager();
  windowManager.addListener(windowLifecycleManager);
  setWindowLifecycleManager(windowLifecycleManager);

  if (Platform.isWindows) {
    launchAtStartup.setup(
      appName: 'Azkari',
      appPath: Platform.resolvedExecutable,
    );
  }

  Future.microtask(() async {
    await Future.delayed(const Duration(seconds: 5));
    await NotificationService().checkAndNotifyMorningOnLaunch();
    await NotificationService().checkAndNotifyEveningOnLaunch();
  });

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => CounterRepository()),
        RepositoryProvider(create: (_) => ProgressRepository()),
        RepositoryProvider(create: (_) => StatsRepository()),
        RepositoryProvider(create: (_) => HijriOffsetRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ThemeCubit()),
          BlocProvider(create: (_) => PinCubit()),
        ],
        child: const AzkariApp(),
      ),
    ),
  );

  if (Platform.isWindows) {
    await windowManager.waitUntilReadyToShow(
      const WindowOptions(
        size: Size(700, 600),
        minimumSize: Size(500, 400),
        maximumSize: Size(700, 600),
        center: true,
        title: 'Azkari App',
        skipTaskbar: false,
      ),
          () async {
        await windowManager.show();
        await windowManager.focus();
      },
    );
  } else {
    await windowManager.show();
    await windowManager.focus();
  }
}