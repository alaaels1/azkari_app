import 'package:azkari_app/core/components/custom_Appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/components/custom_card.dart';

class AzkarSabahView extends StatefulWidget {
  const AzkarSabahView({super.key});

  @override
  State<AzkarSabahView> createState() => _AzkarSabahViewState();
}

class _AzkarSabahViewState extends State<AzkarSabahView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea
      (
        child:
        Scaffold(
            appBar: CustomAppBar(
                icon1: Icons.push_pin_outlined,
                onPressedIcon1: () {},
                icon2: true,
                icon3: Icons.keyboard_arrow_right_rounded,
                onPressedIcon3: () => Navigator.pop(context),
                title: "أذكار الصباح ",

            ),

            body: Column(
              children: [
                const SizedBox(height: 30,),

              ],
            ),
        ), );

  }
}
