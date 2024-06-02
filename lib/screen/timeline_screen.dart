import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mindlog_app/component/timeline_appointment_card.dart';
import 'package:mindlog_app/component/timeline_mindlog_card.dart';
import 'package:mindlog_app/const/visual.dart';
import 'package:mindlog_app/model/appoinment_model.dart';
import 'package:provider/provider.dart';

import '../model/mindlog_model.dart';
import '../provider/mindlog_provider.dart';
import '../provider/schedule_provider.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<ScheduleProvider>().getAppointmentsAll();

    // context.read<MindlogProvider>().getMindlogsByAppointmentId(appointmentId: appointmentId);
  }

  @override
  Widget build(BuildContext context) {
    final mindlogProvider = context.watch<MindlogProvider>();
    final scheduleProvider = context.watch<ScheduleProvider>();

    final allAppointments = scheduleProvider.allAppointments;
    final mindlogsByAppointmentId = mindlogProvider.mindlogsByAppointmentId;

    for (var appointment in allAppointments) {
      int appointmentId = appointment.id;
      context.read<MindlogProvider>().getMindlogsByAppointmentId(appointmentId: appointmentId);
      // print(mindlogsByAppointmentId[appointmentId]); //= List<Mindlog> mindlogs;
    }

    Appointment appointmentTest = Appointment(
      id: 1,
      date: DateTime.now(),
      startTime: '09:00',
      endTime: '09:30',
      hospital: '',
    );

    Mindlog mindlogTest = Mindlog(
        id: 0,
        date: DateTime.now(),
        time: '10:00',
        mood: ['aaa'],
        moodColor: 5,
        title: '오늘 기분 최고!',
        emotionRecord: '오늘 오전엔 기분이 안 좋았는데...',
        eventRecord: '',
        questionRecord: ''
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(30, 10, 20, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            timelineAppointmentCard(appointment: appointmentTest),
            timelineMindlogCard(mindlog: mindlogTest,),
            timelineMindlogCard(mindlog: mindlogTest),
            timelineAppointmentCard(appointment: appointmentTest),
            timelineMindlogCard(mindlog: mindlogTest),
            timelineMindlogCard(mindlog: mindlogTest),
            timelineMindlogCard(mindlog: mindlogTest),
            // timelineAppointmentCard(appointment: appointmentTest),
            // timelineMindlogCard(mindlog: mindlogTest),
          ],
        ),
      ),
    );
  }
}

//feed