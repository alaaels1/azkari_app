import 'package:flutter/material.dart';

/// A compact row that lets the user shift the Hijri date by -2 to +2 days.
/// Shown only when the calendar is in Hijri mode.
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
    final color = Theme.of(context).primaryColor;
    final textTheme = Theme.of(context).textTheme;

    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).dividerColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Label
            Text(
              'ضبط التقويم الهجري',
              style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),

            // Controls
            Row(
              children: [
                // Decrement
                _CircleButton(
                  icon: Icons.remove,
                  enabled: offset > -2,
                  color: color,
                  onTap: () => onChanged(offset - 1),
                ),

                const SizedBox(width: 8),

                // Current offset display
                SizedBox(
                  width: 48,
                  child: Center(
                    child: Text(
                      _label(offset),
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: offset == 0
                            ? Theme.of(context).hintColor
                            : color,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // Increment
                _CircleButton(
                  icon: Icons.add,
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

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final Color color;
  final VoidCallback onTap;

  const _CircleButton({
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
        duration: const Duration(milliseconds: 200),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: enabled ? color.withOpacity(0.15) : Colors.transparent,
          border: Border.all(
            color: enabled ? color : Theme.of(context).disabledColor,
            width: 1.4,
          ),
        ),
        child: Icon(
          icon,
          size: 16,
          color: enabled ? color : Theme.of(context).disabledColor,
        ),
      ),
    );
  }
}
