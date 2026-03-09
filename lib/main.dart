import 'dart:io';
import 'package:azkari_app/features/settings/calendar/widgets/hijri_offset_repository.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:window_manager/window_manager.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'azkari_app.dart';

import 'features/settings/Notifications/app_lifecycle_provider.dart';
import 'features/always_on_top/always_on_top_cubit.dart';
import 'features/counter/data/counter_repository.dart';
import 'features/settings/Notifications/notification_service.dart';
import 'features/settings/Notifications/window_lifecycle_manager.dart';
import 'features/settings/calendar/data/progress_repository.dart';
import 'features/settings/calendar/data/stats_repository.dart';
import 'features/theme/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar', null);
  await Hive.initFlutter();
  await Hive.openBox('azkarBox');
  await windowManager.ensureInitialized();

  // Initialize notification service
  await NotificationService().initialize();

  // Initialize window lifecycle manager for incomplete azkar detection
  final windowLifecycleManager = WindowLifecycleManager();
  windowManager.addListener(windowLifecycleManager);
  setWindowLifecycleManager(windowLifecycleManager);

  final box = Hive.box('azkarBox');

  launchAtStartup.setup(
    appName: 'Azkari',
    appPath: Platform.resolvedExecutable,
  );

  // Check for morning and evening azkar reminders on app launch
  await NotificationService().checkAndNotifyMorningOnLaunch();
  await NotificationService().checkAndNotifyEveningOnLaunch();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => CounterRepository(box)),
        RepositoryProvider(create: (_) => ProgressRepository(box)),
        RepositoryProvider(create: (_) => StatsRepository(box)),
        RepositoryProvider(create: (_) => HijriOffsetRepository(box)),
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

  doWhenWindowReady(() {
    const maxSize = Size(700, 600);
    const minSize = Size(500, 400);

    appWindow.size = maxSize;
    appWindow.minSize = minSize;
    appWindow.maxSize = maxSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = "Azkari App";
    appWindow.show();
  });
}
