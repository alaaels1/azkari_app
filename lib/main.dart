import 'package:azkari_app/core/theme/theme_cubit.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'azkari_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('azkarBox');
  // await Hive.box('azkarBox').clear();


  runApp(
    BlocProvider(create: (context) => ThemeCubit(), child: const AzkariApp()),
  );

  appWindow.size = const Size(700, 600);
  appWindow.show();
  doWhenWindowReady(() {
    const maxsize = Size(700, 600);
    const minsize = Size(500, 400);

    appWindow.minSize = minsize;
    appWindow.maxSize = maxsize;
    appWindow.alignment = Alignment.center;
    appWindow.title = "Custom window with Flutter";
    appWindow.show();
  });
}
