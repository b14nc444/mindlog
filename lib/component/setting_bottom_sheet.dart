import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../const/visual.dart';
import '../provider/schedule_provider.dart';
import '../provider/settings_provider.dart';
import 'appointment_textfield.dart';
import 'hide_keyboard_on_tap.dart';

class settingBottomSheet extends StatefulWidget {
  final int type; // 0=mindlog, 1=medicine
  final Function(TimeOfDay) onTimeSelected;

  const settingBottomSheet({super.key, required this.type, required this.onTimeSelected});

  @override
  State<settingBottomSheet> createState() => _settingBottomSheetState();
}

class _settingBottomSheetState extends State<settingBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  DateTime? _time;

  @override
  Widget build(BuildContext context) {
    // final SettingsProvider = context.watch<SettingsProvider>();

    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    String title = (widget.type == 0) ? '감정 기록 알림 시간' : '약 복용 알림 시간';

    return Form(
      key: formKey,
      child: HideKeyboardOnTap(
        child: Container(
            height: 480 + bottomInset,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Shadow color
                  spreadRadius: 3, // Spread radius
                  blurRadius: 33, // Blur radius
                  offset: const Offset(0, 1), // Offset
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(22, 25, 22, bottomInset),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(title,
                    style: TextStyle(
                        color: secondaryColor3,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.1
                    ),
                  ),
                  if (widget.type == 1)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('복약 메모', style: TextStyle(
                        color: typographyGray3,
                        fontSize: 14,
                        fontFamily: 'Pretendard Variable',
                        fontWeight: FontWeight.bold,
                      ),),
                    ),
                  if (widget.type == 1)
                    SizedBox(
                      height: 45,
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: typographyGray3,
                        maxLines: 1,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(12.0),
                          hintText: '약에 대한 메모를 입력해주세요(선택)',
                          hintStyle: TextStyle(
                            color: typographyGray1,
                            fontSize: 14,
                            fontFamily: 'Pretendard Variable',
                            fontWeight: FontWeight.w500,
                          ),
                          filled: true,
                          fillColor: backgroundColor,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none, // 테두리 없음
                          ),
                        ),
                        style: TextStyle(
                          color: basicBlack,
                          fontSize: 14,
                          fontFamily: 'Pretendard Variable',
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.15,
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 24,
                  ),
                  //Time Picker
                  Container(
                    height: (widget.type == 0) ? 240 : 180,
                    child: TimePickerSpinner(
                      is24HourMode: false,
                      isForce2Digits: true,
                      normalTextStyle: TextStyle(
                        fontSize: 22,
                        color: basicGray,
                      ),
                      highlightedTextStyle: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                      ),
                      itemHeight: 36,
                      onTimeChange: (time) {
                        setState(() {
                          _time = time;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 50,
                    child: FilledButton(
                      onPressed: () {
                        onCreateButtonPressed(context);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: primaryColor,
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text('확인'),
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }

  void onCreateButtonPressed(BuildContext context) async {
    if (formKey.currentState!.validate()) { // 폼 검증
      formKey.currentState!.save(); // 폼 저장

      //추가하는 함수
      if (_time != null) {
        widget.onTimeSelected(TimeOfDay.fromDateTime(_time!));
      }

      Navigator.pop(context);
    }
  }
}
