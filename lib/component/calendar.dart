import 'package:flutter/material.dart';
import 'package:mindlog_app/const/visual.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});


  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime? _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  CalendarFormat _calendarFormat = CalendarFormat.week;

  TextStyle weekTextStyle = const TextStyle(
      color: TYPOGRAPHY_GRAY_2,
      fontSize: 11
  );

  TextStyle dayTextStyle = const TextStyle(
      color: Colors.black,
      fontSize: 12
  );

  TextStyle dayTextStyleWhite = const TextStyle(
      color: Colors.white,
      fontSize: 12
  );

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 1, 1),
      lastDay: DateTime.utc(2050, 12, 31),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      availableCalendarFormats: const {
        CalendarFormat.month: '주',
        CalendarFormat.week: '월',
      },
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      rowHeight: 60, // 요일쪽
      daysOfWeekHeight: 16, // 날짜쪽
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        leftChevronVisible: false, // 왼쪽 화살표 숨기기
        rightChevronVisible: false, // 오른쪽 화살표 숨기기
        titleTextStyle: TextStyle(
            fontSize: 16
        ),
        headerPadding: EdgeInsets.fromLTRB(40, 12, 12, 20),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: weekTextStyle,
        weekendStyle: weekTextStyle,
      ),
      calendarStyle: CalendarStyle(
        weekendTextStyle: dayTextStyle,
        defaultTextStyle: dayTextStyle,
        outsideTextStyle: dayTextStyle,
        todayTextStyle: dayTextStyle,
        todayDecoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        selectedTextStyle: dayTextStyle,
        selectedDecoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: TYPOGRAPHY_GRAY_2,
            width: 1.5,
          )
        ),
      ),
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
        },  // select the day tapped
        onPageChanged: (focusedDay) {
        // No need to call `setState()` here
        _focusedDay = focusedDay;
      },
    // eventLoader: (day) {
    //   return _getEventsForDay(day);
    // },
    );
  }
}