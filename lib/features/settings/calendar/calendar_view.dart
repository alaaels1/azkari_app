import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../core/components/custom_Appbar.dart';
import 'half_circle_indicator.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  late Box box;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    box = Hive.box('azkarBox');
  }

  bool isMorningDone(DateTime day) {
    String key = "morning_completed_${day.year}-${day.month}-${day.day}";
    return box.get(key, defaultValue: false);
  }

  bool isEveningDone(DateTime day) {
    String key = "evening_completed_${day.year}-${day.month}-${day.day}";
    return box.get(key, defaultValue: false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          icon1: Icons.push_pin_outlined,
          onPressedIcon1: () {},
          icon2: false,
          icon3: Icons.keyboard_arrow_right_rounded,
          onPressedIcon3: () => Navigator.pop(context),
          title: "متابعة التقدم",
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TableCalendar(
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
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
              // ✅ إخفاء الـ default decoration عشان ما يتعارضش مع الـ custom
              calendarStyle: const CalendarStyle(
                outsideDaysVisible: false,
                // إخفاء كل الـ decorations الافتراضية
                todayDecoration: BoxDecoration(color: Colors.transparent),
                selectedDecoration: BoxDecoration(color: Colors.transparent),
                todayTextStyle: TextStyle(color: Colors.black),
                selectedTextStyle: TextStyle(color: Colors.black),
              ),
              // ✅ ربط الـ custom builder
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  return _buildDayCell(day);
                },
                todayBuilder: (context, day, focusedDay) {
                  return _buildDayCell(day, isToday: true);
                },
                selectedBuilder: (context, day, focusedDay) {
                  return _buildDayCell(day, isSelected: true);
                },
                outsideBuilder: (context, day, focusedDay) {
                  return _buildDayCell(day, isOutside: true);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDayCell(
      DateTime day, {
        bool isToday = false,
        bool isSelected = false,
        bool isOutside = false,
      }) {
    bool morning = isMorningDone(day);
    bool evening = isEveningDone(day);

    return Stack(
      alignment: Alignment.center,
      children: [
        // ✅ نصف دايرة الصباح (يمين - amber)
        if (morning)
          CustomPaint(
            size: const Size(38, 38),
            painter: HalfCirclePainter(
              color: Colors.amber,
              isLeft: false,
            ),
          ),

        // ✅ نصف دايرة المساء (يسار - blue)
        if (evening)
          CustomPaint(
            size: const Size(38, 38),
            painter: HalfCirclePainter(
              color: Colors.blue,
              isLeft: true,
            ),
          ),

        // ✅ بوردر اليوم الحالي
        if (isToday)
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: 2),
            ),
          ),

        if (isSelected && !isToday)
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.purple, width: 2),
            ),
          ),

        // ✅ رقم اليوم
        Text(
          '${day.day}',
          style: TextStyle(
            color: isOutside
                ? Colors.grey[400]
                : isToday
                ? Colors.grey
                : null,
            fontWeight:
            isToday || morning || evening ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}