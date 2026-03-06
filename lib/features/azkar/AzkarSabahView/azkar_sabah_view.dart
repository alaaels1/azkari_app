import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/components/custom_Appbar.dart';
import '../../../core/components/keyboard_shortcuts.dart';
import '../../../core/utils/completion_dialog.dart';
import '../../counter/data/counter_repository.dart';
import '../../counter/logic/counter_controller.dart';
import '../cubits/azkar_cubit.dart';
import '../cubits/azkar_state.dart';
import '../widgets/azkar_body.dart';

class AzkarSabahView extends StatefulWidget {
  const AzkarSabahView({super.key});

  @override
  State<AzkarSabahView> createState() => _AzkarSabahViewState();
}

class _AzkarSabahViewState extends State<AzkarSabahView> {
  int _currentIndex = 0;
  CounterController? _controller;

  void _initController(int repeat, int totalAzkar) {
    _controller = CounterController(
      repository: context.read<CounterRepository>(),
      index: _currentIndex,
      type: "morning",
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

  Future<void> _onDecrement() async {
    final count = _controller?.loadCount() ?? 0;
    final newCount = await _controller?.decrement(count) ?? 0;
    final allDone = await _controller?.handleZekrCompletion(newCount) ?? false;

    if (allDone && mounted) {
      showCompletionDialog(context, "أذكار الصباح");
    }
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
      onCount: _onDecrement,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
            icon2: true,
            icon3: Icons.keyboard_arrow_right_rounded,
            onPressedIcon3: () => Navigator.pop(context),
            title: "أذكار الصباح",
          ),
          body: AzkarBody(
            azkarList: azkarList,
            currentIndex: _currentIndex,
            controller: _controller!,
            onNext: _goToNext,
            onPrevious: _goToPrevious,
            type: 'morning',
            title: 'أذكار الصباح',

          ),
        ),
      ),
    );
  }
}