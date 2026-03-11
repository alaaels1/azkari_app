import 'package:azkari_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import '../data/stats_repository.dart';

class AzkarStatsSection extends StatelessWidget {
  final StatsRepository statsRepository;

  const AzkarStatsSection({super.key, required this.statsRepository});

  @override
  Widget build(BuildContext context) {
    final stats = statsRepository.calculateStats();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Divider(height: 32),

        Text(
          'إحصائياتك',
          textDirection: TextDirection.rtl,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _StatCard(
              label: 'الصباح والمساء',
              count: stats['both']!,
              icon: Icons.auto_awesome_rounded,
              color: AppColors.thirdColor,
              isDark: isDark,
            ),
            _StatCard(
              label: 'أذكار المساء',
              count: stats['evening']!,
              icon: Icons.nights_stay_rounded,
              color: AppColors.footerColor,
              isDark: isDark,
            ),
            _StatCard(
              label: 'أذكار الصباح',
              count: stats['morning']!,
              icon: Icons.wb_sunny_rounded,
              color: AppColors.accentYellow,
              isDark: isDark,
            ),
          ],
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final int count;
  final IconData icon;
  final Color color;
  final bool isDark;

  const _StatCard({
    required this.label,
    required this.count,
    required this.icon,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.darkCardBackground
            : color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.25), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 22),
          ),

          const SizedBox(height: 10),

          Text(
            '$count',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: color,
              height: 1,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? Colors.white60
                  : AppColors.footerColor,
            ),
          ),
        ],
      ),
    );
  }
}