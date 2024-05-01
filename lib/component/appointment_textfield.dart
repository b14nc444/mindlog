import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mindlog_app/const/visual.dart';

class AppointmentTextField extends StatefulWidget {
  final FormFieldSetter<String> onSavedStartTime;
  final FormFieldSetter<String> onSavedEndTime;
  final FormFieldSetter<String> onSavedHospital;
  final FormFieldSetter<String> onSavedDoctor;

  final FormFieldValidator<String> startTimeValidator;
  final FormFieldValidator<String> endTimeValidator;
  final FormFieldValidator<String> hospitalValidator;
  final FormFieldValidator<String> doctorValidator;

  const AppointmentTextField({super.key,
    required this.onSavedStartTime,
    required this.onSavedEndTime,
    required this.onSavedHospital,
    required this.onSavedDoctor,
    required this.startTimeValidator,
    required this.endTimeValidator,
    required this.hospitalValidator,
    required this.doctorValidator,
  });

  @override
  State<AppointmentTextField> createState() => _AppointmentTextFieldState();
}

class _AppointmentTextFieldState extends State<AppointmentTextField> {

  String startTime = '09:00';
  // final TextEditingController textControllerHospital = TextEditingController();
  // final TextEditingController textControllerDoctor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String _selectedTimeStart;
    String _selectedTimeEnd;
    String _inputText;

    InputDecoration inputDecoration = InputDecoration(
      filled: true,
      fillColor: backgroundColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none, // 테두리 없음
      ),
    );

    InputDecoration inputdecorationTime = InputDecoration(
      filled: true,
      fillColor: backgroundColor,
      border: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide.none, // 테두리 없음
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal:10, vertical: 0),
    );

    TextStyle textStyleLabel = const TextStyle(
        color: secondaryColor3,
        fontWeight: FontWeight.bold
    );

    TextStyle textStyleContent = const TextStyle(
        color: basicBlack,
        fontSize: 14,
        fontFamily: 'Pretendard Variable',
        fontWeight: FontWeight.w500,
        letterSpacing: -0.15,
    );

    TextStyle textStyleHint = const TextStyle(
      color: typographyGray1,
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
              SizedBox(
                width: 95,
                height: 40,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    hintText: '09:00',
                    hintStyle: textStyleHint,
                    filled: true,
                    fillColor: backgroundColor,
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
                      _selectedTimeStart = newValue!;
                      print('start time selected : $_selectedTimeStart');
                    });
                  },
                  icon: dropdownIcon,
                  style: textStyleContent,
                  menuMaxHeight: 180,
                  isExpanded: true,
                  onSaved: widget.onSavedStartTime,
                  validator: widget.startTimeValidator,
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
                    fillColor: backgroundColor,
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
                      _selectedTimeEnd = newValue!;
                      print('end time selected : $_selectedTimeEnd');
                    });
                  },
                  icon: dropdownIcon,
                  style: textStyleContent,
                  menuMaxHeight: 180,
                  isExpanded: true,
                  onSaved: widget.onSavedEndTime,
                  validator: widget.endTimeValidator,
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
              //controller: textControllerHospital,
              textAlignVertical: TextAlignVertical.center,
              cursorColor: typographyGray3,
              maxLines: 1,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(12.0),
                hintText: '병원을 입력해주세요',
                hintStyle: textStyleHint,
                filled: true,
                fillColor: backgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none, // 테두리 없음
                ),
              ),
              style: textStyleContent,
              onSaved: widget.onSavedHospital,
              validator: widget.hospitalValidator,
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
              //controller: textControllerDoctor,
              cursorColor: typographyGray3,
              maxLines: 1,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(12.0),
                hintText: '주치의를 입력해주세요(선택)',
                hintStyle: textStyleHint,
                filled: true,
                fillColor: backgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none, // 테두리 없음
                ),
              ),
              style: textStyleContent,
              onSaved: widget.onSavedDoctor,
              validator: widget.doctorValidator,
            ),
          ),
        ],
    );
  }
}