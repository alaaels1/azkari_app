import 'package:azkari_app/core/components/custom_info_card.dart';
import 'package:flutter/material.dart';
import '../../../core/components/custom_appbar.dart';
import 'data/privacy_data.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          icon2: false,
          icon3: Icons.keyboard_arrow_right_rounded,
          onPressedIcon3: () => Navigator.pop(context),
          title: 'سياسة الخصوصية',
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: privacySections.length,
          itemBuilder: (context, index) => CustomInfoCard(
            section: privacySections[index],
          ),
        ),
      ),
    );
  }
}