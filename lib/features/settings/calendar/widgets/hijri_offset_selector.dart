import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class HijriOffsetSelector extends StatelessWidget {
  final int offset;
  final ValueChanged<int> onChanged;

  const HijriOffsetSelector({
    super.key,
    required this.offset,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = Theme.of(context).primaryColor;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCardBackground : AppColors.appBarBackground2,
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
            Text(
              'ضبط التقويم',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isDark ? AppColors.thirdColor : AppColors.secondaryColor,
              ),
            ),

            const SizedBox(width: 12),

            Row(
              children: [
                _SmallButton(
                  icon: Icons.remove_rounded,
                  enabled: offset > -2,
                  color: color,
                  onTap: () => onChanged(offset - 1),
                ),

                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 180),
                  child: SizedBox(
                    key: ValueKey(offset),
                    width: 46,
                    child: Center(
                      child: Text(
                        _label(offset),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: offset == 0
                              ? (isDark ? Colors.white38 : AppColors.footerColor)
                              : color,
                        ),
                      ),
                    ),
                  ),
                ),

                _SmallButton(
                  icon: Icons.add_rounded,
                  enabled: offset < 2,
                  color: color,
                  onTap: () => onChanged(offset + 1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _label(int v) {
    if (v == 0) return 'تلقائي';
    return v > 0 ? '+$v يوم' : '$v يوم';
  }
}

class _SmallButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final Color color;
  final VoidCallback onTap;

  const _SmallButton({
    required this.icon,
    required this.enabled,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: enabled ? color.withOpacity(0.12) : Colors.transparent,
          border: Border.all(
            color: enabled ? color.withOpacity(0.5) : Theme.of(context).disabledColor,
            width: 1.2,
          ),
        ),
        child: Icon(
          icon,
          size: 14,
          color: enabled ? color : Theme.of(context).disabledColor,
        ),
      ),
    );
  }
}