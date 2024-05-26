import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../const/visual.dart';
import '../model/mindlog_model.dart';

class timelineMindlogCard extends StatelessWidget {
  final Mindlog mindlog;

  const timelineMindlogCard({super.key, required this.mindlog});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('M.d', 'ko_KR').format(mindlog.date!);
    String mindlogContent = (mindlog.emotionRecord.length > 20) ? '${mindlog.emotionRecord.substring(0, 20)}...' : mindlog.emotionRecord;

    Color? iconColor;

    switch(mindlog.moodColor) {
      case 1:
        iconColor = Color(0xffFF6362);
      case 2:
        iconColor = Color(0xffFF9A4E);
      case 3:
        iconColor = Color(0xffF6C649);
      case 4:
        iconColor = Color(0xffC8DD6E);
      case 5:
        iconColor = Color(0xff78D358);
    }

    return Column(
      children: [
        Row(
          children: [
            Column(
              children: [
                Text(formattedDate, style: TextStyle(
                  color: basicBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),),
                Text(mindlog.time, style: TextStyle(
                  color: typographyGray1,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),),
              ],
            ),
            SizedBox(width: 12,),
            Icon(Icons.circle, color: iconColor, size: 14,),
            SizedBox(width: 25,),
            Expanded(
              child: Container(
                width: 235,
                height: 80,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            mindlog.title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            mindlogContent,
                            style: TextStyle(
                              color: basicGray,
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.15,
                            ),
                          ),
                        ],
                      ),
                      Icon(Icons.arrow_forward_ios_rounded, color: guideGray,)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 20,),
      ],
    );
  }
}
