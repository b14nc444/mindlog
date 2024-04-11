import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  CalendarFormat _calendarFormat = CalendarFormat.week;


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
          // formatButtonVisible: false,
          leftChevronVisible: false, // 왼쪽 화살표 숨기기
          rightChevronVisible: false, // 오른쪽 화살표 숨기기
          titleTextStyle: TextStyle(
              fontSize: 16
          ),
        headerPadding: EdgeInsets.fromLTRB(40, 15, 12, 20),
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