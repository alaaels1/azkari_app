import 'package:azkari_app/features/settings/calendar/widgets/day_cell.dart';
import 'package:azkari_app/features/settings/calendar/widgets/calendar_type_selector.dart';
import 'package:azkari_app/features/settings/calendar/widgets/azkar_stats_section.dart';
import 'package:azkari_app/features/settings/calendar/widgets/hijri_helper.dart';
import 'package:azkari_app/features/settings/calendar/widgets/hijri_offset_repository.dart';
import 'package:azkari_app/features/settings/calendar/widgets/hijri_offset_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../../core/components/custom_Appbar.dart';
import 'data/progress_repository.dart';
import 'data/stats_repository.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  late ProgressRepository _progressRepo;
  late StatsRepository _statsRepo;
  late HijriOffsetRepository _offsetRepo;

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarType _calendarType = CalendarType.gregorian;
  int _hijriOffset = 0;
  bool _showOffsetSelector = false; // hidden by default

  @override
  void initState() {
    super.initState();
    _progressRepo = context.read<ProgressRepository>();
    _statsRepo = context.read<StatsRepository>();
    _offsetRepo = context.read<HijriOffsetRepository>();
    _hijriOffset = _offsetRepo.getOffset();
  }

  Future<void> _updateOffset(int newOffset) async {
    await _offsetRepo.setOffset(newOffset);
    setState(() => _hijriOffset = newOffset);
  }

  @override
  Widget build(BuildContext context) {
    final isHijri = _calendarType == CalendarType.hijri;

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          icon2: false,
          icon3: Icons.keyboard_arrow_right_rounded,
          onPressedIcon3: () => Navigator.pop(context),
          title: "متابعة التقدم",
          actions: isHijri
              ? [
                  IconButton(
                    tooltip: 'ضبط التقويم الهجري',
                    icon: Icon(
                      _showOffsetSelector
                          ? Icons.tune
                          : Icons.tune_outlined,
                      color: _hijriOffset != 0
                          ? Theme.of(context).primaryColor
                          : null,
                    ),
                    onPressed: () => setState(
                        () => _showOffsetSelector = !_showOffsetSelector),
                  ),
                ]
              : null,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CalenderTypeSelector(
                selected: _calendarType,
                onChanged: (type) => setState(() {
                  _calendarType = type;
                  // hide selector when switching away from hijri
                  if (type != CalendarType.hijri) {
                    _showOffsetSelector = false;
                  }
                }),
              ),

              // Offset row — only when hijri AND user tapped the tune icon
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) => SizeTransition(
                  sizeFactor: animation,
                  child: FadeTransition(opacity: animation, child: child),
                ),
                child: (isHijri && _showOffsetSelector)
                    ? HijriOffsetSelector(
                        key: const ValueKey('offset'),
                        offset: _hijriOffset,
                        onChanged: _updateOffset,
                      )
                    : const SizedBox.shrink(key: ValueKey('empty')),
              ),

              TableCalendar(
                locale: 'ar',
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                daysOfWeekHeight: 32,
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: const TextStyle(fontWeight: FontWeight.w600),
                  weekendStyle: const TextStyle(fontWeight: FontWeight.w600),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextFormatter: (date, locale) => isHijri
                      ? HijriHelper.formatHijri(date, offset: _hijriOffset)
                      : DateFormat.yMMMM(locale).format(date),
                ),
                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: false,
                  todayDecoration: BoxDecoration(color: Colors.transparent),
                  selectedDecoration: BoxDecoration(color: Colors.transparent),
                  todayTextStyle: TextStyle(color: Colors.black),
                  selectedTextStyle: TextStyle(color: Colors.black),
                ),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, _) => _buildCell(day),
                  todayBuilder: (context, day, _) =>
                      _buildCell(day, isToday: true),
                  selectedBuilder: (context, day, _) =>
                      _buildCell(day, isSelected: true),
                  outsideBuilder: (context, day, _) =>
                      _buildCell(day, isOutside: true),
                ),
              ),

              AzkarStatsSection(statsRepository: _statsRepo),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCell(
    DateTime day, {
    bool isToday = false,
    bool isSelected = false,
    bool isOutside = false,
  }) {
    return DayCell(
      day: day,
      morning: _progressRepo.isCompletedOnDay("morning", day),
      evening: _progressRepo.isCompletedOnDay("evening", day),
      isToday: isToday,
      isSelected: isSelected,
      isOutside: isOutside,
      calendarType: _calendarType,
      hijriOffset: _hijriOffset,
    );
  }
}