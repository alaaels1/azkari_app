import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

enum CalendarType { gregorian, hijri }

class CalenderTypeSelector extends StatelessWidget {
  final CalendarType selected;
  final ValueChanged<CalendarType> onChanged;

  const CalenderTypeSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkCardBackground
            : AppColors.appBarBackground2,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOption(context,
              label: "ميلادي",
              type: CalendarType.gregorian,
              icon: Icons.calendar_today_rounded),
          _buildOption(context,
              label: "هجري",
              type: CalendarType.hijri,
              icon: Icons.nightlight_round),
        ],
      ),
    );
  }

  Widget _buildOption(
      BuildContext context, {
        required String label,
        required CalendarType type,
        required IconData icon,
      }) {
    final isSelected = selected == type;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => onChanged(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? AppColors.footerColor : AppColors.secondaryColor)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isSelected
              ? [
            BoxShadow(
              color: AppColors.secondaryColor.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 15,
              color: isSelected
                  ? Colors.white
                  : (isDark ? AppColors.thirdColor : AppColors.footerColor),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: isSelected
                    ? Colors.white
                    : (isDark ? AppColors.thirdColor : AppColors.footerColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}