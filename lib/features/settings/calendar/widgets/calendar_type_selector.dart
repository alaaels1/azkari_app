import 'package:flutter/material.dart';

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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Theme.of(context).dividerColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOption(context, label: "ميلادي", type: CalendarType.gregorian),
          _buildOption(context, label: "هجري", type: CalendarType.hijri),
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required String label,
    required CalendarType type,
  }) {
    final isSelected = selected == type;

    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(type),
        child: AnimatedContainer(
          duration: const Duration(microseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ?Theme.of(context).splashColor : Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
