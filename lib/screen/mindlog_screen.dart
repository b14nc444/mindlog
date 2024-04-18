import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mindlog_app/component/mindlog_question.dart';
import 'package:mindlog_app/component/mindlog_textfield.dart';
import 'package:mindlog_app/const/visual.dart';
import 'package:mindlog_app/model/mindlog_model.dart';
import 'package:mindlog_app/service/db_server.dart';

import '../component/hide_keyboard_on_tap.dart';

class mindlogScreen extends StatefulWidget {

  final DateTime selectedDate;

  const mindlogScreen({super.key, required this.selectedDate});

  @override
  State<mindlogScreen> createState() => _mindlogScreenState();
}

class _mindlogScreenState extends State<mindlogScreen> {

  final GlobalKey<FormState> formKey = GlobalKey();

  String? date;
  String? moodColor;
  String? title;
  String? emotion;
  String? event;
  String? question;

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

    initializeDateFormatting('ko_KR');
    String formattedDate = DateFormat('yyyy-MM-dd(E)', 'ko_KR').format(widget.selectedDate);
    date = formattedDate;

    return Form(
      key: formKey,
      child: Scaffold(
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
                onCreateButtonPressed();
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
                    onSaved: (String? val) {title = val;},
                    validator: contentValidator,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Column(
                    children: [
                      const mindlogQuestion(question: '1. 감정을 기록합니다.'),
                      mindlogTextField(hintText: '감정을 기록해주세요',
                        onSavedContent: (String? val) {emotion = val;},
                        contentValidator: contentValidator,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const mindlogQuestion(question: '2. 이벤트를 기록합니다.'),
                      mindlogTextField(hintText: '이벤트를 기록해주세요',
                        onSavedContent: (String? val) {event = val;},
                        contentValidator: contentValidator,),
                      const SizedBox(
                        height: 10,
                      ),
                      const mindlogQuestion(question: '3. 질문을 기록합니다.'),
                      mindlogTextField(hintText: '질문을 기록해주세요',
                        onSavedContent: (String? val) {question = val;},
                        contentValidator: contentValidator,),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? contentValidator(String? val) {
    if(val == null || val.length == 0) {
      return 'cant be null';
    }
    return null;
  }

  void onCreateButtonPressed() {
    if(formKey.currentState!.validate()) {  // 폼 검증
      formKey.currentState!.save();  // 폼 저장
      createMindlog(context, Mindlog(
        date: date,
        moodColor: moodColor,
        title: title,
        emotionRecord: emotion,
        eventRecord: event,
        questionRecord: question,
      ));

      print('date : $date');
      print('mood color : $moodColor');
      print('title : $title');
      print('emotion record : $emotion');
      print('event record : $event');
      print('question record: $question');
    } else {
      print("null can't exist");
    }
  }
}
