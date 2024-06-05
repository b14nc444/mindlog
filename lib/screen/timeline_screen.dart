import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mindlog_app/component/timeline_appointment_card.dart';
import 'package:mindlog_app/component/timeline_mindlog_card.dart';
import 'package:mindlog_app/const/visual.dart';
import 'package:mindlog_app/model/appoinment_model.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';

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
            // FixedTimeline.tileBuilder(
            //   builder: TimelineTileBuilder.connected(
            //     connectionDirection: ConnectionDirection.before,
            //     itemCount: allAppointments.length,
            //     contentsBuilder: (context, index) {
            //       final appointment = allAppointments[index];
            //       return Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             timelineAppointmentCard(appointment: appointment),
            //             if (mindlogsByAppointmentId[appointment.id] != null)
            //               ...mindlogsByAppointmentId[appointment.id]!.map((mindlog) {
            //                 return Padding(
            //                   padding: const EdgeInsets.symmetric(vertical: 8.0),
            //                   child: timelineMindlogCard(mindlog: mindlog),
            //                 );
            //               }).toList(),
            //           ],
            //         ),
            //       );
            //     },
            //     indicatorBuilder: (context, index) {
            //       return DotIndicator(
            //         color: Colors.blue,
            //         size: 20.0,
            //       );
            //     },
            //     connectorBuilder: (context, index, type) {
            //       return SolidLineConnector(
            //         color: Colors.blue,
            //         thickness: 2.0,
            //       );
            //     },
            //   ),
            // ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(), // 스크롤 비활성화
              reverse: true,
              shrinkWrap: true,
              itemCount: allAppointments.length,
              itemBuilder: (BuildContext context, int index) {
                final appointment = allAppointments[index];
                return Column(
                  children: [
                    timelineAppointmentCard(appointment: appointment,),
                    // 딸린 Mindlog가 있을 경우
                    if(mindlogsByAppointmentId[appointment.id] != null)
                      // 각 딸린 Mindlog 조회
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(), // 스크롤 비활성화
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: mindlogsByAppointmentId[appointment.id]!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final mindlog = mindlogsByAppointmentId[appointment.id]![index];
                          return timelineMindlogCard(mindlog: mindlog,);
                        },
                      ),
                      // FixedTimeline.tileBuilder(
                      //   builder: TimelineTileBuilder.connected(
                      //     connectionDirection: ConnectionDirection.before,
                      //     itemCount: mindlogsByAppointmentId[appointment.id]!.length,
                      //     contentsBuilder: (BuildContext context, int index) {
                      //       final mindlog = mindlogsByAppointmentId[appointment.id]![index];
                      //       return timelineMindlogCard(mindlog: mindlog,);
                      //     },
                      //   ),
                      // ),
                  ],
                );
              },
            ),
            //////TEST/////////
            // timelineAppointmentCard(appointment: appointmentTest),
            // timelineMindlogCard(mindlog: mindlogTest,),
            // timelineMindlogCard(mindlog: mindlogTest),
            // timelineAppointmentCard(appointment: appointmentTest),
            // timelineMindlogCard(mindlog: mindlogTest),
            // timelineMindlogCard(mindlog: mindlogTest),
            // timelineMindlogCard(mindlog: mindlogTest),
            // timelineAppointmentCard(appointment: appointmentTest),
            // timelineMindlogCard(mindlog: mindlogTest),
          ],
        ),
      ),
    );
  }
}

//feed