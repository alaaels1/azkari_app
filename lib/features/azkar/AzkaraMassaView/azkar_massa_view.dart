import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/components/custom_appbar.dart';
import '../../../core/components/keyboard_shortcuts.dart';
import '../../counter/data/counter_repository.dart';
import '../../counter/logic/counter_controller.dart';
import '../../counter/widgets/custom_counter.dart';
import '../cubits/azkar_cubit.dart';
import '../cubits/azkar_state.dart';
import '../widgets/azkar_body.dart';

class AzkarMassaView extends StatefulWidget {
  const AzkarMassaView({super.key});

  @override
  State<AzkarMassaView> createState() => _AzkarMassaViewState();

}

class _AzkarMassaViewState extends State<AzkarMassaView> {
  int _currentIndex = 0;
  final GlobalKey<CustomCounterState> _counterKey = GlobalKey<CustomCounterState>();

  CounterController? _controller;

  void _initController(int repeat, int totalAzkar) {
    _controller = CounterController(
      repository: context.read<CounterRepository>(),
      index: _currentIndex,
      type: "evening",
      repeat: repeat,
      minRequired: 1,
      totalAzkar: totalAzkar,
    );
  }

  void _goToNext() {
    if (_controller?.isLastZekr == true) return;
    setState(() => _currentIndex++);
  }

  void _goToPrevious() {
    if (_currentIndex <= 0) return;
    setState(() => _currentIndex--);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AzkarCubit, AzkarStates>(
      builder: (context, state) {
        return switch (state) {
          AzkarLoading() => const Center(child: CircularProgressIndicator()),
          AzkarError()   => Center(child: Text(state.error)),
          AzkarSuccess() => _buildScaffold(state),
          _              => const SizedBox(),
        };
      },
    );
  }

  Widget _buildScaffold(AzkarSuccess state) {
    final azkarList = state.azkarModel.content;
    final zekr = azkarList[_currentIndex];

    _initController(zekr.repeat, azkarList.length);

    return KeyboardShortcuts(
      onNextPage: _goToNext,
      onPreviousPage: _goToPrevious,
      onCount: () => _counterKey.currentState?.decrement(),
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            icon2: true,
            icon3: Icons.keyboard_arrow_right_rounded,
            onPressedIcon3: () => Navigator.pop(context),
            title: "أذكار المساء",
          ),
          body: AzkarBody(
            azkarList: azkarList,
            counterKey: _counterKey,
            currentIndex: _currentIndex,
            controller: _controller!,
            type: "evening",
            title: "أذكار المساء",
            onNext: _goToNext,
            onPrevious: _goToPrevious,
          ),
        ),
      ),
    );
  }
}
