import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindlog_app/const/visual.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../provider/mindlog_provider.dart';
import '../provider/schedule_provider.dart';

class Calendar extends StatefulWidget {

  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final CalendarFormat _calendarFormat = CalendarFormat.week;

  TextStyle weekTextStyle = const TextStyle(
      color: typographyGray2,
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
  void initState() {
    super.initState();
    context.read<ScheduleProvider>().getAppointmentsAll();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ScheduleProvider>();

    final selectedDay = provider.selectedDate;
    DateTime focusedDay = selectedDay;

    final Set<DateTime> appointmentDays = {};
    for (var appointment in provider.allAppointments) {
      appointmentDays.add(appointment.date);
    }

    return Column(
      children: [
        // Text(appointmentDays.last.toString()),
        TableCalendar(
          firstDay: DateTime.utc(2010, 1, 1),
          lastDay: DateTime.utc(2050, 12, 31),
          focusedDay: focusedDay,
          calendarFormat: _calendarFormat,
          // availableCalendarFormats: const {
          //   CalendarFormat.month: '주',
          //   CalendarFormat.week: '월',
          // },
          // onFormatChanged: (format) {
          //   setState(() {
          //     _calendarFormat = format;
          //   });
          // },
          rowHeight: 60, // 요일쪽 높이
          daysOfWeekHeight: 16, // 날짜쪽 높이
          headerStyle: const HeaderStyle(
            formatButtonVisible: false,
            leftChevronVisible: false, // 왼쪽 화살표 숨기기
            rightChevronVisible: false, // 오른쪽 화살표 숨기기
            titleTextStyle: TextStyle(
                fontSize: 16
            ),
            headerPadding: EdgeInsets.fromLTRB(14, 14, 12, 20),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: weekTextStyle,
            weekendStyle: weekTextStyle,
          ),
          calendarStyle: CalendarStyle(
            weekendTextStyle: dayTextStyle,
            defaultTextStyle: dayTextStyle,
            outsideTextStyle: dayTextStyle,
            // todayTextStyle: dayTextStyle,
            // todayDecoration: const BoxDecoration(
            //   color: CupertinoColors.systemGrey5,
            //   shape: BoxShape.circle,
            // ),
            // selectedTextStyle: dayTextStyle,
            // selectedDecoration: BoxDecoration(
            //   shape: BoxShape.circle,
            //   border: Border.all(
            //     color: typographyGray2,
            //     width: 1.5,
            //   )
            // ),
          ),
          selectedDayPredicate: (date) => isSameDay(selectedDay, date),
          onDaySelected: (selectedDay, focusedDay) {
            onDaySelected(selectedDay, focusedDay, context);
          },
          calendarBuilders: CalendarBuilders(
            defaultBuilder: (context, day, focusedDay) {
              bool isSelected = isSameDay(selectedDay, day);
              bool isToday = isSameDay(day, DateTime.now());
              bool hasAppointment = appointmentDays.contains(day);

              return Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: hasAppointment ? Colors.blueAccent : null,
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(color: typographyGray2, width: 1.5)
                      : null,
                ),
                child: Text(
                  day.day.toString(),
                  style: isSelected || hasAppointment
                      ? dayTextStyleWhite
                      : dayTextStyle,
                ),
              );
            },
            selectedBuilder: (context, date, _) {
              bool isToday = isSameDay(date, DateTime.now());
              bool hasAppointment = appointmentDays.contains(date);

              return Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: hasAppointment ? Colors.blueAccent : (isToday ? CupertinoColors.systemGrey5 : Colors.transparent),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: typographyGray2,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  date.day.toString(),
                  style: hasAppointment ? dayTextStyleWhite : dayTextStyle,
                ),
              );
            },
            todayBuilder: (context, date, _) {
              bool hasAppointment = appointmentDays.contains(date);
              return Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: hasAppointment ? Colors.blueAccent : CupertinoColors.systemGrey5,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  date.day.toString(),
                  style: hasAppointment ? dayTextStyleWhite : dayTextStyle,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate, BuildContext context) {
    final scheduleProvider = context.read<ScheduleProvider>();
    final mindlogProvider = context.read<MindlogProvider>();

    // String formattedDate = DateFormat('yyyy-MM-dd', 'ko_KR').format(selectedDate);
    setState(() {
      scheduleProvider.changeSelectedDate(date: selectedDate);
      scheduleProvider.getAppointmentByDate(date: selectedDate);
      mindlogProvider.getMindlogByDate(date: selectedDate);
    });
  }
}