import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindlog_app/component/mindlog_question.dart';
import 'package:mindlog_app/component/mindlog_textviewer.dart';
import 'package:mindlog_app/const/visual.dart';

import '../component/mindlog_bottom_menu.dart';
import '../model/mindlog_model.dart';

class mindlogViewerScreen extends StatefulWidget {

  final Mindlog mindlog;

  const mindlogViewerScreen({super.key, required this.mindlog,});

  @override
  State<mindlogViewerScreen> createState() => _mindlogViewerScreenState();
}

class _mindlogViewerScreenState extends State<mindlogViewerScreen> {

  TextStyle textStyleTitle = const TextStyle(
    color: basicBlack,
    fontSize: 22,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.bold,
    letterSpacing: -0.15,
  );

  @override
  Widget build(BuildContext context) {

    Mindlog mindlog = widget.mindlog;
    String formattedDate = DateFormat('yyyy년 M월 d일', 'ko_KR').format(mindlog.date);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          leadingWidth: 66,
          leading: TextButton(
            child: arrowBackIcon,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  //mainAxisAlignment: MainAxisAlignment.,
                  children: [
                    SizedBox(
                        width: double.infinity,
                        child: Text(mindlog.title, style: textStyleTitle) // 제목
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: SizedBox(
                          width: 360,
                          child: titleStroke // 구분선
                      ),
                    ),
                    SizedBox(
                        width: double.infinity,
                        child: Text('$formattedDate ${mindlog.time}',
                            style: const TextStyle(
                                color: typographyGray1,
                                fontWeight: FontWeight.w300,
                                fontSize: 13,
                                fontFamily: 'pretendard'
                            )
                        )
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              getHeartImageByMoodColor(mindlog.moodColor),
                              SizedBox(width: 18,),
                              Container(
                                width: 1,
                                height: 45,
                                color: guideGray,
                              ),
                              SizedBox(width: 18,),
                              Expanded(
                                child: SizedBox(
                                  height: 35,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: mindlog.mood.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      final mood = mindlog.mood[index];
                                      return Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 5),
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        decoration: BoxDecoration(
                                          color: backgroundColor,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Center(
                                            child: Text(mood, style: const TextStyle(
                                              color: basicBlack,
                                              fontSize: 14,
                                            ))
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ),
                    ),
                    const mindlogQuestion(
                      question: '1. 오늘의 감정',
                      direction: '오늘의 감정은 어떠했나요?\n우울함, 불안함 등의 감정이 들었다면 몇점으로 평가할 수 있을까요?(10점 만점)'
                          '\n그 감정이 해소될 때까지의 시간은 얼마나 걸렸는지,\n동시에 자동적으로 떠올랐던 생각을 자유롭게 적어주세요.',
                    ),
                    mindlogTextViewer(content: mindlog.emotionRecord),
                    const SizedBox(
                      height: 10,
                    ),
                    const mindlogQuestion(
                      question: '2. 특별한 이벤트',
                      direction: '나의 감정에 영향을 미친 이벤트가 있다면 기록해주세요.\n그 이벤트가 나에게 미친 영향이 어떠한지를 기록합니다.'
                          '\n감정/행동이 바뀌었다면 그 변화에 대해 기록해주세요.',
                    ),
                    mindlogTextViewer(content: mindlog.eventRecord),
                    const SizedBox(
                      height: 10,
                    ),
                    // if (mindlog.questionRecord != null)
                    const mindlogQuestion(
                      question: '3. 주치의와 상담하고 싶은 내용',
                      direction: '약 먹었을 때 불편했던 것, 일상생활 중 궁금했던 것,\n'
                          '치료 방향 그리고 특별히 주치의와 상담하고 싶은 내용이 있다면 기록해주세요.',
                    ),
                    mindlogTextViewer(content: mindlog.questionRecord!),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: mindlogBottomMenu(mindlog: mindlog),
    );
  }

  Image getHeartImageByMoodColor(int moodColor) {
    switch (moodColor) {
      case 1:
        return Image.asset('assets/hearts/heart_background_red.png');
      case 2:
        return Image.asset('assets/hearts/heart_background_orange.png');
      case 3:
        return Image.asset('assets/hearts/heart_background_yellow.png');
      case 4:
        return Image.asset('assets/hearts/heart_background_yellowgreen.png');
      case 5:
        return Image.asset('assets/hearts/heart_background_green.png');
      default:
        return heartEmpty;
    }
  }
}