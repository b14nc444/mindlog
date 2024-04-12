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
    TextStyle textStyle = TextStyle(
        color: SECONDARY_COLOR_3,
        fontWeight: FontWeight.bold
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('시간', style: textStyle),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              InkWell(
                onTap: (){
                },
                child: SizedBox(
                  width: 90,
                  height: 40,
                  child: Container(
                    decoration: BoxDecoration(
                      color: BACKGROUND_COLOR,
                      borderRadius: BorderRadius.circular(8)
                    ),
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text('~'),
              ),
              SizedBox(
                width: 90,
                height: 40,
                child: TextFormField(
                  readOnly: true,
                  onTap: () {
                    // 클릭하면 드롭다운 목록 표시
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((value) {
                      // 선택한 시간을 저장
                      if (value != null) {
                        setState(() {
                          _selectedTime = value.format(context);
                        });
                      }
                    });
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text('병원', style: textStyle),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            cursorColor: TYPOGRAPHY_GRAY_3,
            maxLines: 1,
            keyboardType: TextInputType.multiline,
            decoration: inputDecoration,
          ),
          SizedBox(
            height: 10,
          ),
          Text('주치의', style: textStyle),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            cursorColor: TYPOGRAPHY_GRAY_3,
            maxLines: 1,
            keyboardType: TextInputType.multiline,
            decoration: inputDecoration,
          ),
        ],
    );
  }
}