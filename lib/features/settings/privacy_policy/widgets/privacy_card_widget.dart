import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/privacy_model.dart';

class PrivacySectionCard extends StatelessWidget {
  final PrivacySection section;

  const PrivacySectionCard({
    super.key,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _SectionTitle(title: section.title),
          const SizedBox(height: 10),
          const Divider(endIndent: 0, indent: 0),
          const SizedBox(height: 10),
          _SectionContent(content: section.content),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          title,
          textDirection: TextDirection.rtl,
          style: GoogleFonts.tajawal(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A2F45),
          ),
        ),
        const SizedBox(width: 8),
        const Icon(
          Icons.privacy_tip_outlined,
          color: Color(0xFF1A2F45),
          size: 20,
        ),
      ],
    );
  }
}

class _SectionContent extends StatelessWidget {
  final String content;

  const _SectionContent({required this.content});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      textDirection: TextDirection.rtl,
      textAlign: TextAlign.justify,
      style: GoogleFonts.tajawal(
        fontSize: 15,
        height: 1.8,
        color: Colors.black87,
      ),
    );
  }
}