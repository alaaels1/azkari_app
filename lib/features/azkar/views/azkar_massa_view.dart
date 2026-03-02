import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/components/custom_Appbar.dart';
import '../../../core/components/custom_card.dart';
import '../../../core/components/custom_counter.dart';
import '../../../core/utils/helpers.dart';
import '../cubits/azkar_cubit.dart';
import '../cubits/azkar_state.dart';
import '../models/azkar_model.dart';

class AzkarMassaView extends StatefulWidget {
  const AzkarMassaView({super.key});

  @override
  State<AzkarMassaView> createState() => _AzkarMassaViewState();
}

class _AzkarMassaViewState extends State<AzkarMassaView> {

  int currentIndex = 0;

  List<ZekrContent> azkarList = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AzkarCubit, AzkarStates>(
      builder: (context, state) {

        if (state is AzkarLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is AzkarSuccess) {

          final azkarList = state.azkarModel.content;
          final zekr = azkarList[currentIndex];

          return SafeArea(
            child: Scaffold(
              appBar: CustomAppBar(
                icon1: Icons.push_pin_outlined,
                onPressedIcon1: () {},
                icon2: true,
                icon3: Icons.keyboard_arrow_right_rounded,
                onPressedIcon3: () => Navigator.pop(context),
                title: "أذكار المساء",
              ),
              body: Stack(
                children: [
                  Column(
                    children: [

                      const SizedBox(height: 30),

                      Expanded(
                        child: Center(
                          child: CustomCard(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${zekr.zekr}\n\n",
                                    style: TextStyle(
                                      color: Theme.of(context).textTheme.bodyMedium?.color,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  TextSpan(
                                    text: zekr.bless,
                                    style: TextStyle(
                                      color:Theme.of(context).textTheme.bodySmall?.color,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),

                      CustomCounter(
                        key: ValueKey(currentIndex),
                        index: currentIndex,
                        type: "evening",
                        repeat: zekr.repeat,
                        minRequired: 1,
                        totalAzkar: azkarList.length,
                        onAllCompleted: () {
                          showCompletionDialog(context, "أذكار المساء");
                        },
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                  Positioned(
                    left: 2,
                    top: MediaQuery.of(context).size.height * 0.4,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: currentIndex < azkarList.length - 1
                          ? () {
                        setState(() {
                          currentIndex++;
                        });
                      }
                          : null,
                    ),
                  ),

                  Positioned(
                    right: 2,
                    top: MediaQuery.of(context).size.height * 0.4,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed:  currentIndex > 0
                          ? () {
                        setState(() {
                          currentIndex--;
                        });
                      }
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is AzkarError) {
          return Center(child: Text(state.error));
        }

        return const SizedBox();
      },
    );
  }
}