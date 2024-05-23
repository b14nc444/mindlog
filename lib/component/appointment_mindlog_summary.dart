import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../const/visual.dart';
import '../model/appoinment_model.dart';
import '../model/mindlog_model.dart';

class appointmentMindlogSummary extends StatefulWidget {
  final Mindlog mindlog;

  const appointmentMindlogSummary({super.key, required this.mindlog});

  @override
  State<appointmentMindlogSummary> createState() => _appointmentMindlogSummaryState();
}

class _appointmentMindlogSummaryState extends State<appointmentMindlogSummary> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {

    Mindlog mindlog = widget.mindlog;
    String formattedDate = DateFormat('yyyy.MM.dd', 'ko_KR').format(mindlog.date);

    Color? borderColor;
    Color? contentColor;

    switch(mindlog.moodColor) {
      case 1:
        borderColor = Color(0xffFF6362);
      case 2:
        borderColor = Color(0xffFF9A4E);
      case 3:
        borderColor = Color(0xffF6C649);
      case 4:
        borderColor = Color(0xffC8DD6E);
      case 5:
        borderColor = Color(0xff78D358);
    }

    switch(mindlog.moodColor) {
      case 1:
        contentColor = Color(0xffF4E3DF);
      case 2:
        contentColor = Color(0xffF7EFE6);
      case 3:
        contentColor = Color(0xffF4F0DF);
      case 4:
        contentColor = Color(0xffF1F6E0);
      case 5:
        contentColor = Color(0xffE9EFE6);
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: borderColor!, // 테두리 색상
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
                Text(mindlog.title, style: TextStyle(
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
            Text('$formattedDate ${mindlog.time}', style: TextStyle(
              color: basicGray,
              letterSpacing: -0.18,
            ),),
            if(_isExpanded)
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildContentContainer(
                        title: '감정',
                        content: mindlog.emotionRecord,
                        contentColor: contentColor!
                    ),
                    SizedBox(height: 16,),
                    _buildContentContainer(
                        title: '이벤트',
                        content: mindlog.eventRecord,
                        contentColor: contentColor!
                    ),
                    SizedBox(height: 6,),
                    if (mindlog.questionRecord?.isNotEmpty == true)
                      SizedBox(height: 10),
                    if (mindlog.questionRecord?.isNotEmpty == true)
                      _buildContentContainer(
                          title: '질문',
                          content: mindlog.questionRecord!,
                          contentColor: contentColor!
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

  Widget _buildContentContainer({
    required String title,
    required String content,
    required Color contentColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(
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
                color: contentColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(content, style: TextStyle(
                  color: basicBlack
                ),),
                ),
              ),
            ),
          ],
        ),
      ]
    );
  }
}
