import 'package:flutter/material.dart';

import '../const/visual.dart';
import '../model/appoinment_model.dart';

class appointmentMindlogSummary extends StatefulWidget {
  final Appointment appointment;

  const appointmentMindlogSummary({super.key, required this.appointment});

  @override
  State<appointmentMindlogSummary> createState() => _appointmentMindlogSummaryState();
}

class _appointmentMindlogSummaryState extends State<appointmentMindlogSummary> {
  bool _isExpanded = false;
  // if (appointment.moodColor == 1) color

  @override
  Widget build(BuildContext context) {
    return Container(
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
                GestureDetector(
                    onTap: () {
                      //print('toggle arrow is tapped');
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: _isExpanded ? Icon(Icons.arrow_drop_up) : Icon(Icons.arrow_drop_down)
                ), // toggleArrowUp
              ],
            ),
            Text('2024.04.15 9:10', style: TextStyle(
              color: basicGray,
              letterSpacing: -0.18,
            ),),
            if(_isExpanded)
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
    );
  }
}
