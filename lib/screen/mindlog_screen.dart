import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindlog_app/component/mindlog_question.dart';
import 'package:mindlog_app/component/mindlog_textfield.dart';
import 'package:mindlog_app/const/visual.dart';

import '../component/hide_keyboard_on_tap.dart';

class mindlogScreen extends StatefulWidget {
  const mindlogScreen({super.key});

  @override
  State<mindlogScreen> createState() => _mindlogScreenState();
}

class _mindlogScreenState extends State<mindlogScreen> {

  TextStyle textStyleHintTitle = const TextStyle(
    color: TYPOGRAPHY_GRAY,
    fontSize: 23,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w600,
    letterSpacing: -0.15,
  );

  TextStyle textStyleContent = const TextStyle(
    color: BASIC_BLACK,
    fontSize: 22,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.normal,
    letterSpacing: -0.15,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        leadingWidth: 66,
        leading: TextButton(
          child: Text('취소',
            style: TextStyle(
              color: TYPOGRAPHY_GRAY,
              fontSize: 16
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          TextButton(
            child: Text('완료',
              style: TextStyle(
                  color: PRIMARY_COLOR,
                  fontSize: 16
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              print('');
            },
          ),
        ],
      ),
      body: HideKeyboardOnTap(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  cursorColor: TYPOGRAPHY_GRAY_3,
                  maxLines: 1,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: '오늘을 요약하는 제목을 적어주세요',
                    hintStyle: textStyleHintTitle,
                  ),
                  style: textStyleContent,
                ),
                const SizedBox(
                  height: 24,
                ),
                const Column(
                  children: [
                    mindlogQuestion(question: '1. 감정을 기록합니다.'),
                    mindlogTextField(hintText: '감정을 기록해주세요',),
                    SizedBox(
                      height: 10,
                    ),
                    mindlogQuestion(question: '2. 이벤트를 기록합니다.'),
                    mindlogTextField(hintText: '이벤트를 기록해주세요',),
                    SizedBox(
                      height: 10,
                    ),
                    mindlogQuestion(question: '3. 질문을 기록합니다.'),
                    mindlogTextField(hintText: '질문을 기록해주세요',),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
