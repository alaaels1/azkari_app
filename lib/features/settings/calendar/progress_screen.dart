import 'package:azkari_app/features/settings/calendar/widgets/day_cell.dart';
import 'package:azkari_app/features/settings/calendar/widgets/calendar_type_selector.dart';
import 'package:azkari_app/features/settings/calendar/widgets/azkar_stats_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
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

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarType _calendarType = CalendarType.gregorian;

  @override
  void initState() {
    super.initState();
    _progressRepo = context.read<ProgressRepository>();
    _statsRepo = context.read<StatsRepository>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          icon2: false,
          icon3: Icons.keyboard_arrow_right_rounded,
          onPressedIcon3: () => Navigator.pop(context),
          title: "متابعة التقدم",
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              CalenderTypeSelector(
                selected: _calendarType,
                onChanged: (type) =>
                    setState(() => _calendarType = type),
              ),

              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) =>
                    isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: false,
                  todayDecoration:
                  BoxDecoration(color: Colors.transparent),
                  selectedDecoration:
                  BoxDecoration(color: Colors.transparent),
                  todayTextStyle: TextStyle(color: Colors.black),
                  selectedTextStyle: TextStyle(color: Colors.black),
                ),
                calendarBuilders: CalendarBuilders(
                  defaultBuilder: (context, day, _) =>
                      _buildCell(day),
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
    );
  }
}