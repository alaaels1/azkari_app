import 'package:azkari_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import '../data/stats_repository.dart';

class AzkarStatsSection extends StatelessWidget {
  final StatsRepository statsRepository;

  const AzkarStatsSection({
    super.key,
    required this.statsRepository,
  });

  @override
  Widget build(BuildContext context) {
    final stats = statsRepository.calculateStats();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [

        const Divider(height: 32),

        Center(
          child: Text(
            'إحصائياتك',
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
        ),

        const SizedBox(height: 30),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _StatItem(
              label: 'الصباح والمساء',
              count: stats['both']!,
              icon: Icons.auto_awesome_rounded,
              iconColor: AppColors.thirdColor,
            ),

            _StatItem(
              label: 'أذكار المساء',
              count: stats['evening']!,
              icon: Icons.nights_stay_rounded,
              iconColor: AppColors.footerColor,
            ),
            _StatItem(
              label: 'أذكار الصباح',
              count: stats['morning']!,
              icon: Icons.wb_sunny_rounded,
              iconColor: AppColors.accentYellow,
            ),




          ],
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final int count;
  final IconData icon;
  final Color iconColor;

  const _StatItem({
    required this.label,
    required this.count,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Icon(icon, color: iconColor, size: 28),

        const SizedBox(height: 8),

        Text(
          '$count',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.footerColor,
          ),
        ),

      ],
    );
  }
}