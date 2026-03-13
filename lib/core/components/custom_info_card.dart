import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/info_model.dart';

class CustomInfoCard extends StatelessWidget {
  final InfoSection section;
  final Widget? trailing;

  const CustomInfoCard({
    super.key,
    required this.section,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                section.title,
                textDirection: TextDirection.rtl,
                style: GoogleFonts.cairo(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primary,
                ),
              ),
              const SizedBox(width: 8),
              Icon(section.icon, color: primary, size: 20), // ← section.icon مش icon
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          const SizedBox(height: 10),
          Text(
            section.content,
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.justify,
            style: GoogleFonts.cairo(
              fontSize: 15,
              height: 1.8,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(height: 12),
            trailing!,
          ],
        ],
      ),
    );
  }
}