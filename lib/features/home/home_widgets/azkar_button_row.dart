import 'package:flutter/material.dart';
import '../../../core/components/custom_button.dart';
import '../../../core/constants/app_colors.dart';

class AzkarButtonsRow extends StatelessWidget {
  final VoidCallback onEveningPressed;
  final VoidCallback onMorningPressed;

  const AzkarButtonsRow({
    super.key,
    required this.onEveningPressed,
    required this.onMorningPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            text: "أذكار المساء",
            color: AppColors.thirdColor,
            hoverColor: AppColors.basicColor,
            textColor: AppColors.secondaryColor,
            fontSize: size.width * 0.04,
            height: size.height * 0.17,
            width: size.width * 0.34,
            radius: 5,
            borderWidth: 0,
            borderColor: Colors.transparent,
            onPressed: onEveningPressed,
            hoverTextColor: AppColors.thirdColor,
          ),

          SizedBox(width: size.height * 0.2),

          CustomButton(
            text: "أذكار الصباح",
            color: AppColors.thirdColor,
            hoverColor: AppColors.accentYellow,
            textColor: AppColors.secondaryColor,
            fontSize: size.width * 0.04,
            height: size.height * 0.17,
            width: size.width * 0.34,
            radius: 5,
            borderWidth: 0,
            borderColor: Colors.transparent,
            onPressed: onMorningPressed,
            hoverTextColor: AppColors.secondaryColor,
          ),
        ],
      ),
    );
  }
}
