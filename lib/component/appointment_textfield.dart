import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mindlog_app/const/visual.dart';

class AppointmentTextField extends StatefulWidget {
  // final String label;
  // final bool isTime;

  const AppointmentTextField({super.key});

  @override
  State<AppointmentTextField> createState() => _AppointmentTextFieldState();
}

class _AppointmentTextFieldState extends State<AppointmentTextField> {
  String startTime = '09:00';

  @override
  Widget build(BuildContext context) {
    String _selectedTime;
    String _inputText;

    InputDecoration inputDecoration = InputDecoration(
      filled: true,
      fillColor: BACKGROUND_COLOR,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none, // 테두리 없음
      ),
    );

    InputDecoration inputdecorationTime = InputDecoration(
      filled: true,
      fillColor: BACKGROUND_COLOR,
      border: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none, // 테두리 없음
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
    );

    TextStyle textStyleLabel = const TextStyle(
        color: SECONDARY_COLOR_3,
        fontWeight: FontWeight.bold
    );

    TextStyle textStyleContent = const TextStyle(
        color: BASIC_BLACK,
        fontSize: 14,
        fontFamily: 'Pretendard Variable',
        fontWeight: FontWeight.w500,
        letterSpacing: -0.15,
    );

    TextStyle textStyleHint = const TextStyle(
      color: TYPOGRAPHY_GRAY,
      fontSize: 14,
      fontFamily: 'Pretendard Variable',
      fontWeight: FontWeight.w500,
      letterSpacing: -0.15,
    );

    List<String> timeList = [];
    for (int hour = 0; hour < 24; hour++) {
      for (int minute = 0; minute < 60; minute += 5) {
        String hourStr = hour.toString().padLeft(2, '0');
        String minuteStr = minute.toString().padLeft(2, '0');
        timeList.add('$hourStr:$minuteStr');
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('시간', style: textStyleLabel),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              InkWell(
                onTap: (){
                },
                child: SizedBox(
                  width: 95,
                  height: 40,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      hintText: '09:00',
                      hintStyle: textStyleHint,
                      filled: true,
                      fillColor: BACKGROUND_COLOR,
                      border: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none, // 테두리 없음
                      ),
                    ),
                    items: timeList.map((String time) {
                      return DropdownMenuItem<String>(
                        value: time,
                        child: Text(time,),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedTime = newValue!;
                      });
                    },
                    icon: dropdownIcon,
                    style: textStyleContent,
                    menuMaxHeight: 180,
                    isExpanded: true,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Text('~'),
              ),
              SizedBox(
                width: 95,
                height: 40,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: '09:30',
                    hintStyle: textStyleHint,
                    filled: true,
                    fillColor: BACKGROUND_COLOR,
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide.none, // 테두리 없음
                    ),
                  ),
                  items: timeList.map((String time) {
                    return DropdownMenuItem<String>(
                      value: time,
                      child: Text(time),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedTime = newValue!;
                    });
                  },
                  icon: dropdownIcon,
                  style: textStyleContent,
                  menuMaxHeight: 180,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 14,
          ),
          Text('병원', style: textStyleLabel),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 45,
            child: TextFormField(
              cursorColor: TYPOGRAPHY_GRAY_3,
              maxLines: 1,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: '병원을 입력해주세요.',
                hintStyle: textStyleHint,
                filled: true,
                fillColor: BACKGROUND_COLOR,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none, // 테두리 없음
                ),
              ),
              style: textStyleContent,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Text('주치의', style: textStyleLabel),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 45,
            child: TextFormField(
              cursorColor: TYPOGRAPHY_GRAY_3,
              maxLines: 1,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: '주치의를 입력해주세요.',
                hintStyle: textStyleHint,
                filled: true,
                fillColor: BACKGROUND_COLOR,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none, // 테두리 없음
                ),
              ),
              style: textStyleContent,
            ),
          ),

        ],
    );
  }
}