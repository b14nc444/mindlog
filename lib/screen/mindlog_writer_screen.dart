import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mindlog_app/component/mindlog_question.dart';
import 'package:mindlog_app/component/mindlog_textfield.dart';
import 'package:mindlog_app/const/visual.dart';
import 'package:mindlog_app/model/mindlog_model.dart';
import 'package:mindlog_app/provider/mindlog_provider.dart';
import 'package:provider/provider.dart';

import '../component/hide_keyboard_on_tap.dart';
import '../component/mindlog_mood_picker.dart';

class mindlogWriterScreen extends StatefulWidget {
  final bool isUpdate;
  final Mindlog? modifyingMindlog;

  const mindlogWriterScreen({super.key, required this.isUpdate, this.modifyingMindlog});

  @override
  State<mindlogWriterScreen> createState() => _mindlogWriterScreenState();
}

class _mindlogWriterScreenState extends State<mindlogWriterScreen> {

  final GlobalKey<FormState> formKey = GlobalKey();

  DateTime? date = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String? time = DateFormat('hh:mm').format(DateTime.now());
  List<String>? mood;
  int? moodColor;
  String? title;
  String? emotion;
  String? event;
  String? question;

  TextStyle textStyleHintTitle = const TextStyle(
    color: typographyGray1,
    fontSize: 23,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w600,
    letterSpacing: -0.15,
  );

  TextStyle textStyleContent = const TextStyle(
    color: basicBlack,
    fontSize: 22,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.normal,
    letterSpacing: -0.15,
  );

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ko_KR');
    // final provider = context.watch<MindlogProvider>();

    mood = context.watch<MindlogProvider>().selectedMoods;
    moodColor = context.watch<MindlogProvider>().moodColor;

    if (widget.isUpdate && widget.modifyingMindlog != null) {
      date = widget.modifyingMindlog!.date;
      time = widget.modifyingMindlog!.time;
      mood = widget.modifyingMindlog!.mood;
      moodColor = widget.modifyingMindlog!.moodColor;
      title = widget.modifyingMindlog!.title;
      emotion = widget.modifyingMindlog!.emotionRecord;
      event = widget.modifyingMindlog!.eventRecord;
      question = widget.modifyingMindlog!.questionRecord;
    }

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
                color: typographyGray1,
                fontSize: 16
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              // 취소하면 선택했던 감정들 초기화
              context.read<MindlogProvider>().selectedMoods = [];
              context.read<MindlogProvider>().moodColor = 0;
            },
          ),
          actions: [
            TextButton(
              child: const Text('완료',
                style: TextStyle(
                    color: primaryColor,
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
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // /////////test/////////
                  // Text(date.toString()), Text(time.toString()),
                  TextFormField(
                    cursorColor: typographyGray3,
                    maxLines: 1,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: '오늘을 요약하는 제목을 적어주세요',
                      hintStyle: textStyleHintTitle,
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor), // 포커스 상태에서의 밑줄 색상
                      ),
                    ),
                    style: textStyleContent,
                    initialValue: title,
                    onSaved: (String? val) {title = val;},
                    validator: contentValidator,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Column(
                    children: [
                      mindlogMoodPicker(
                        mood: mood,
                        moodColor: moodColor,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const mindlogQuestion(
                        question: '1. 감정을 기록합니다.',
                        direction: '오늘의 감정은 어떠했나요?\n우울함, 불안함 등의 감정이 들었다면 몇점으로 평가할 수 있을까요?(10점 만점)'
                            '\n그 감정이 해소될 때까지의 시간은 얼마나 걸렸는지,\n동시에 자동적으로 떠올랐던 생각을 자유롭게 적어주세요.',
                      ),
                      mindlogTextField(
                        hintText: '감정을 기록해주세요',
                        initialValue: emotion,
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
                      mindlogTextField(
                        hintText: '이벤트를 기록해주세요',
                        initialValue: event,
                        onSavedContent: (String? val) {event = val;},
                        contentValidator: contentValidator,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const mindlogQuestion(
                        question: '3. 질문을 기록합니다.',
                        direction: '약 먹었을 때 불편했던 것, 일상생활 중 궁금했던 것,\n'
                        '치료 방향 그리고 특별히 주치의와 상담하고 싶은 내용이 있다면 기록해주세요.',
                      ),
                      mindlogTextField(
                        hintText: '질문을 기록해주세요(선택)',
                        initialValue: question,
                        onSavedContent: (String? val) {question = val;},
                        contentValidator: contentCanNullValidator,
                      ),
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
    if(val == null || val.isEmpty) {
      return '내용을 입력하세요';
    }
    return null;
  }

  String? contentCanNullValidator(String? val) {
    return null;
  }

  String? moodValidator(List<String>? mood, int? moodColor, BuildContext context) {
    if (mood == null || mood.isEmpty || moodColor == null || moodColor == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('기분을 선택해주세요.'),
          duration: Duration(seconds: 2),
          backgroundColor: primaryColor,
        ),
      );
      return ''; // 빈 문자열 반환
    }
    return null;
  }

  void onCreateButtonPressed() {
    if(formKey.currentState!.validate() && moodValidator(mood, moodColor, context) == null) {  // 폼 검증
      formKey.currentState!.save();  // 폼 저장

      // getMindlogByDate(context, '2024-04-20(토)');
      // getMindlogById(context, 3);
      // deleteMindlog(context, 1);
      if(widget.isUpdate == false) {  // 새로운 기록
        context.read<MindlogProvider>().createMindlog(
            mindlog: Mindlog(
                id: 0,
                date: date!,
                time: time!,
                mood: mood!,
                moodColor: moodColor!,
                title: title!,
                emotionRecord: emotion!,
                eventRecord: event!,
                questionRecord: question)
        );
      } else {  // 기존 기록 수정
        context.read<MindlogProvider>().updateMindlog(
            id: widget.modifyingMindlog!.id,
            mindlog: Mindlog(  // 수정 시 id와 date는 기존 값 유지
                id: widget.modifyingMindlog!.id,
                date: widget.modifyingMindlog!.date,
                time: widget.modifyingMindlog!.time,
                mood: mood!,
                moodColor: moodColor!,
                title: title!,
                emotionRecord: emotion!,
                eventRecord: event!,
                questionRecord: question,
            )
        );
      }

      print('-----input data-----');
      widget.isUpdate ? print('updated') : print('created');
      print('date : $date');
      print('time : $time');
      print('mood : $mood');
      print('mood color : $moodColor');
      print('title : $title');
      print('emotion record : $emotion');
      print('event record : $event');
      print('question record: $question');

      context.read<MindlogProvider>().selectedMoods = [];
      context.read<MindlogProvider>().moodColor = 0;
      Navigator.pop(context);
    } else {
      print("null can't exist");
    }
  }
}
