import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mindlog_app/component/mindlog_question.dart';
import 'package:mindlog_app/component/mindlog_textfield.dart';
import 'package:mindlog_app/const/visual.dart';
import 'package:mindlog_app/model/mindlog_model.dart';

import '../component/hide_keyboard_on_tap.dart';
import '../service/db_server_mindlog.dart';

class mindlogWriterScreen extends StatefulWidget {

  final DateTime selectedDate;

  const mindlogWriterScreen({super.key, required this.selectedDate});

  @override
  State<mindlogWriterScreen> createState() => _mindlogWriterScreenState();
}

class _mindlogWriterScreenState extends State<mindlogWriterScreen> {

  final GlobalKey<FormState> formKey = GlobalKey();

  String? date;
  String? mood;
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
            child: const Text('취소',
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
              child: const Text('완료',
                style: TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 16
                ),
              ),
              onPressed: () {
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
                      const mindlogQuestion(
                        question: '1. 감정을 기록합니다.',
                        direction: '오늘의 감정은 어떠했나요?\n우울함, 불안함 등의 감정이 들었다면 몇점으로 평가할 수 있을까요?(10점 만점)'
                            '\n그 감정이 해소될 때까지의 시간은 얼마나 걸렸는지,\n동시에 자동적으로 떠올랐던 생각을 자유롭게 적어주세요.',
                      ),
                      mindlogTextField(hintText: '감정을 기록해주세요',
                        onSavedContent: (String? val) {emotion = val;},
                        contentValidator: contentValidator,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const mindlogQuestion(
                        question: '2. 이벤트를 기록합니다.',
                        direction: '나의 감정에 영향을 미친 이벤트가 있다면 기록해주세요.\n그 이벤트가 나에게 미친 영향이 어떠한지를 기록합니다.'
                          '\n감정/행동이 바뀌었다면 그 변화에 대해 기록해주세요.',
                      ),
                      mindlogTextField(hintText: '이벤트를 기록해주세요',
                        onSavedContent: (String? val) {event = val;},
                        contentValidator: contentValidator,),
                      const SizedBox(
                        height: 10,
                      ),
                      const mindlogQuestion(
                        question: '3. 질문을 기록합니다.',
                        direction: '약 먹었을 때 불편했던 것, 일상생활 중 궁금했던 것,\n'
                        '치료 방향 그리고 특별히 주치의와 상담하고 싶은 내용이 있다면 기록해주세요.',
                      ),
                      mindlogTextField(hintText: '질문을 기록해주세요(선택)',
                        onSavedContent: (String? val) {question = val;},
                        contentValidator: contentCanNullValidator,),
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

  String? contentCanNullValidator(String? val) {
    return null;
  }

  void onCreateButtonPressed() {
    if(formKey.currentState!.validate()) {  // 폼 검증
      formKey.currentState!.save();  // 폼 저장

      // getMindlogByDate(context, '2024-04-20(토)');
      // getMindlogById(context, 3);
      // deleteMindlog(context, 1);
      createMindlog(context, Mindlog(
        date: date,
        mood: 'positive',
        moodColor: '???',
        title: title,
        emotionRecord: emotion,
        eventRecord: event,
        questionRecord: question,
      ));

      print('-----input data-----');
      print('date : $date');
      print('mood : $mood');
      print('mood color : $moodColor');
      print('title : $title');
      print('emotion record : $emotion');
      print('event record : $event');
      print('question record: $question');

      Navigator.pop(context);
    } else {
      print("null can't exist");
    }
  }
}