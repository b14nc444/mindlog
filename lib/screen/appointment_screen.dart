import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindlog_app/component/mindlog_card.dart';
import 'package:mindlog_app/const/visual.dart';

import '../model/appoinment_model.dart';

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
      body: SingleChildScrollView(
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
                    Text(appointment.date,
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
                // appointment recording card
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('아직 녹음을 하지 않았어요'),
                        Image.asset('assets/icons/record_button.png')
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text('감정 기록 요약', style: textStyleTitle),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Color(0xFF78D358), // 테두리 색상
                      width: 2.5, // 테두리 두께
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // 그림자 색상
                        spreadRadius: -1, // 그림자의 확산 범위
                        blurRadius: 17, // 그림자의 흐릿한 정도
                        offset: Offset(0, 6), // 그림자의 위치 (수평, 수직)
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('오늘 기분 최고!', style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -0.18,
                            ),),
                            Icon(Icons.arrow_drop_up)
                            // toggleArrowUp
                          ],
                        ),
                        Text('2024.04.15 9:10', style: TextStyle(
                          color: basicGray,
                          letterSpacing: -0.18,
                        ),),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('감정', style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),),
                              SizedBox(height: 10,),
                              Flex(
                                direction: Axis.horizontal,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFE9EFE6),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text('감정 text\nsample', style: TextStyle(
                                            color: basicBlack
                                        ),),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16,),
                              Text('이벤트', style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),),
                              SizedBox(height: 10,),
                              Container(
                                width: double.infinity,
                                height: 80,
                                decoration: BoxDecoration(
                                    color: Color(0xFFE9EFE6),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('이벤트 text', style: TextStyle(
                                      color: basicBlack
                                  ),),
                                ),
                              ),
                              SizedBox(height: 16,),
                              Text('질문', style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),),
                              SizedBox(height: 10,),
                              Container(
                                width: double.infinity,
                                height: 80,
                                decoration: BoxDecoration(
                                    color: Color(0xFFE9EFE6),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text('질문 Text', style: TextStyle(
                                      color: basicBlack
                                  ),),
                                ),
                              ),
                              SizedBox(height: 6,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                Text('진료 메모', style: textStyleTitle),
                const SizedBox(height: 10,),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      child: Container(
                        constraints: const BoxConstraints(minHeight: 80.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('진료메모')
                        ),
                      ),
                    )
                  ]
                ),
                const SizedBox(height: 80,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}