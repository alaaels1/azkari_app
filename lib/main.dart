import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:window_manager/window_manager.dart';

import 'azkari_app.dart';
import 'features/always_on_top/always_on_top_cubit.dart';
import 'features/counter/data/counter_repository.dart';
import 'features/settings/calendar/data/progress_repository.dart';
import 'features/settings/calendar/data/stats_repository.dart';
import 'features/theme/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('azkarBox');
  await windowManager.ensureInitialized();

  final box = Hive.box('azkarBox');

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => CounterRepository(box),
        ),
        RepositoryProvider(
          create: (_) => ProgressRepository(box),
        ),
        RepositoryProvider(
          create: (_) => StatsRepository(box),
        ),
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
