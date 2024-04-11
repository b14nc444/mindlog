import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {

  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 1, 1),
      lastDay: DateTime.utc(2050, 12, 31),
      focusedDay: _focusedDay,
      calendarFormat: CalendarFormat.week,
      headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleTextStyle: TextStyle(
              fontSize: 16
          )
      ),
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      // onDaySelected: (selectedDay, focusedDay) {
      //   if (!isSameDay(_selectedDay, selectedDay)) {
      //     setState(() {
      //       _selectedDay = selectedDay;
      //       _focusedDay = focusedDay;
      //     });
      //   }
      //   },  // select the day tapped
    // onFormatChanged: (format) {
    //   if (_calendarFormat != format) {
    //     // Call `setState()` when updating calendar format
    //     setState(() {
    //       _calendarFormat = format;
    //     });
    //   }
    // },
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