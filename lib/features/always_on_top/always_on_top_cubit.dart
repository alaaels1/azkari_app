import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_manager/window_manager.dart';
import 'always_on_top_states.dart';

class PinCubit extends Cubit<PinState> {
  PinCubit() : super(PinInitial());

  bool _isPinned = false;

  bool get isPinned => _isPinned;

  Future<void> togglePin() async {
    _isPinned = !_isPinned;

    await windowManager.setAlwaysOnTop(_isPinned);
    await windowManager.focus();

    if (_isPinned) {
      emit(PinEnabled());
    } else {
      emit(PinDisabled());
    }
  }
}