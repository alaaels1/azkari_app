import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launch_at_startup/launch_at_startup.dart';

part 'startup_states.dart';

class StartupCubit extends Cubit<StartupState> {
  StartupCubit() : super(StartupInitial()) {
    _init();
  }

  void _init() {
    launchAtStartup.setup(
      appName: 'Azkari',
      appPath: Platform.resolvedExecutable,
    );
  }

  Future<void> loadStatus() async {
    emit(StartupLoading());

    final isEnabled = await launchAtStartup.isEnabled();

    emit(isEnabled ? StartupEnabled() : StartupDisabled());
  }

  Future<void> toggle(bool value) async {
    if (value) {
      await launchAtStartup.enable();
      emit(StartupEnabled());
    } else {
      await launchAtStartup.disable();
      emit(StartupDisabled());
    }
  }
}