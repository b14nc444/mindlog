import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mindlog_app/component/mindlog_question.dart';
import 'package:mindlog_app/component/mindlog_textviewer.dart';
import 'package:mindlog_app/const/visual.dart';

import '../component/mindlog_bottom_menu.dart';

class mindlogViewerScreen extends StatefulWidget {

  final DateTime selectedDate;

  const mindlogViewerScreen({super.key, required this.selectedDate});

  @override
  State<mindlogViewerScreen> createState() => _mindlogViewerScreenState();
}

class _mindlogViewerScreenState extends State<mindlogViewerScreen> {

  String? formattedDateTime;
  String? date;
  String? mood;
  String? moodColor;
  String? title;
  String? emotion;
  String? event;
  String? question;

  TextStyle textStyleTitle = const TextStyle(
    color: BASIC_BLACK,
    fontSize: 22,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.bold,
    letterSpacing: -0.15,
  );

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ko_KR');
    String formattedDateTime = DateFormat('yyyy년 M월 d일 HH:MM', 'ko_KR')
        .format(widget.selectedDate);
    date = formattedDateTime;

    //for test
    String testTitle = '오늘 기분 최고!';
    String testContent1 = '오늘 오전엔 기분이 안좋았는데, 오후에는 기분이 좀 좋아졌다.\n그리고 별거 아니었는데 기분 안 좋았던 이유를 생각해보면 그냥 아침에 늦게 일어나서 다 망한 것 같아서 그랬나보다';
    String testContent2 = '할머니가 요양원에 들어가셨다.\n가기 전까지는 딱히 아무 생각 없었는데,\n엄마가 마지막으로 할머니랑 안아주라고 하는데 할머니가 엄마랑 싸우지 말고 잘 지내라고 했다. 그리고 고생했다고 말해줬다.\n확실히 가족들에 관련한 일은 마음을 쉽게흔드는 것 같다.';
    String testContent3 = '요즘 자꾸 자면서 깬다.\n그래서 아침에 늦게 일어난 것 같다.\n그리고 요즘 생각하기에 인내심은 길어진 것 같은데, 약간 상황판단력이 좀 떨어진 느낌도 든다.';

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
          padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  //mainAxisAlignment: MainAxisAlignment.,
                  children: [
                    SizedBox(
                        width: double.infinity,
                        child: Text(testTitle, style: textStyleTitle) // 제목
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
                        child: Text(formattedDateTime,
                            style: const TextStyle(
                                color: TYPOGRAPHY_GRAY,
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
                    const mindlogQuestion(
                      question: '1. 오늘의 감정',
                      direction: '오늘의 감정은 어떠했나요?\n우울함, 불안함 등의 감정이 들었다면 몇점으로 평가할 수 있을까요?(10점 만점)'
                          '\n그 감정이 해소될 때까지의 시간은 얼마나 걸렸는지,\n동시에 자동적으로 떠올랐던 생각을 자유롭게 적어주세요.',
                    ),
                    mindlogTextViewer(content: testContent1),
                    const SizedBox(
                      height: 10,
                    ),
                    const mindlogQuestion(
                      question: '2. 특별한 이벤트',
                      direction: '나의 감정에 영향을 미친 이벤트가 있다면 기록해주세요.\n그 이벤트가 나에게 미친 영향이 어떠한지를 기록합니다.'
                          '\n감정/행동이 바뀌었다면 그 변화에 대해 기록해주세요.',
                    ),
                    mindlogTextViewer(content: testContent2),
                    const SizedBox(
                      height: 10,
                    ),
                    const mindlogQuestion(
                      question: '3. 주치의와 상담하고 싶은 내용',
                      direction: '약 먹었을 때 불편했던 것, 일상생활 중 궁금했던 것,\n'
                          '치료 방향 그리고 특별히 주치의와 상담하고 싶은 내용이 있다면 기록해주세요.',
                    ),
                    mindlogTextViewer(content: testContent3),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: mindlogBottomMenu(),
    );
  }
}