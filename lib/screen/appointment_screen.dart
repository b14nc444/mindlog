import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mindlog_app/component/appointment_memo.dart';
import 'package:mindlog_app/component/appointment_mindlog_summary.dart';
import 'package:mindlog_app/component/appointment_record.dart';
import 'package:mindlog_app/component/hide_keyboard_on_tap.dart';
import 'package:mindlog_app/component/mindlog_card.dart';
import 'package:mindlog_app/const/visual.dart';
import 'package:provider/provider.dart';

import '../model/appoinment_model.dart';
import '../model/mindlog_model.dart';
import '../provider/mindlog_provider.dart';
import 'mindlog_viewer_screen.dart';

class appointmentScreen extends StatefulWidget {
  final Appointment appointment;

  const appointmentScreen({super.key, required this.appointment});

  @override
  State<appointmentScreen> createState() => _appointmentScreenState();
}

class _appointmentScreenState extends State<appointmentScreen> {

  @override
  Widget build(BuildContext context) {
    Appointment appointment = widget.appointment;

    final mindlogProvider = context.watch<MindlogProvider>();
    final mindlogs = mindlogProvider.mindlogsByAppointmentId[appointment.id];

    context.read<MindlogProvider>().getMindlogsByAppointmentId(appointmentId: appointment.id);

    String formattedDate = DateFormat('yyyy-MM-dd(E)', 'ko_KR').format(appointment.date!);

    TextStyle textStyleTitle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: basicGray,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: HideKeyboardOnTap(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.today),
                      const SizedBox(width: 4,),
                      Text(formattedDate,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor
                        ),
                      ),
                      const Text('에 등록된 진료를',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: basicBlack
                        ),
                      ),
                    ],
                  ),
                  const Text('기록합니다',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: basicBlack
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('진료 일정', style: textStyleTitle,),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              const Text('시간',
                                style: TextStyle(color: primaryColor),
                              ),
                              const SizedBox(width: 30,),
                              Text('${appointment.startTime} - ${appointment.endTime}'),
                            ],
                          ),
                          Row(
                            children: [
                              const Text('주치의',
                                style: TextStyle(color: primaryColor),
                              ),
                              const SizedBox(width: 18,),
                              Text(
                                (appointment.doctorName != null) ? '${appointment.doctorName} (${appointment.hospital})' : '${appointment.hospital}',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('진료 내용', style: textStyleTitle),
                  const SizedBox(
                    height: 10,
                  ),
                  appointmentRecord(appointment: appointment,),  // appointment recording card
                  const SizedBox(
                    height: 24,
                  ),
                  Text('감정 기록 요약', style: textStyleTitle),
                  const SizedBox(
                    height: 10,
                  ),
                  if (mindlogs != null)
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: mindlogs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final mindlog = mindlogs[index];
                        return Column(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => mindlogViewerScreen(
                                        mindlog: mindlog,)
                                      )
                                  );
                                },
                                child: appointmentMindlogSummary(mindlog: mindlog,)
                            ),
                            const SizedBox(height: 20,),
                          ],
                        );
                      }
                    ),
                  if (mindlogs == null)
                    Text('기록이 없습니다.'),
                  // appointmentMindlogSummary(mindlog: Mindlog(id: 1, date: DateTime.now(), time: '9:10', mood: [], moodColor: 5, title: '오늘 기분 최고!', emotionRecord: '감정 text\nsample', eventRecord: '이벤트 text\n이벤트 text\n이벤트 text\n이벤트 text', questionRecord: '//'),),
                  // const SizedBox(height: 30,),
                  Text('진료 메모', style: textStyleTitle),
                  const SizedBox(height: 10,),
                  appointmentMemo(appointment: appointment,),
                  const SizedBox(height: 80,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}