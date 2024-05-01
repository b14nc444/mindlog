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
    color: basicBlack,
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
    String testTitle = '저희 진짜 열심히 했어요';
    String testContent1 = '피곤하다… 시험 하나만 봐서 별로 안 바쁠 줄 알았는데 생각보다 할 게 많음';
    String testContent2 = '친구들 만나러 다녀옴 근데 바빠서 생각보다 오래 못 놀고 들어와서 아쉬웠다';
    String testContent3 = '피곤하고 무기력할 때는 어떻게 해야 하지 힘이 안 난다';

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
                        child: Text('2024년 4월 20일 22:04',
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