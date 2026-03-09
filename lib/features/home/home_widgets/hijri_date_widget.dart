import 'package:azkari_app/features/settings/calendar/widgets/hijri_offset_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../settings/calendar/widgets/hijri_helper.dart';

class HijriDateWidget extends StatelessWidget {
  const HijriDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final offset = context.read<HijriOffsetRepository>().getOffset();
    final screenWidth = MediaQuery.of(context).size.width;

    return RichText(
      textDirection: TextDirection.rtl,
      text: TextSpan(
        style: GoogleFonts.cairo(
          fontSize: screenWidth * 0.03,
          fontWeight: FontWeight.w500,
          color: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.color
              ?.withOpacity(0.7),
        ),
        children: [
          TextSpan(
            text: HijriHelper.dual(DateTime.now(), offset: offset),
          ),
        ],
      ),
    );
  }
}