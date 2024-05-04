import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mindlog_app/component/appointment_textfield.dart';
import 'package:mindlog_app/component/hide_keyboard_on_tap.dart';
import 'package:mindlog_app/const/visual.dart';
import 'package:mindlog_app/provider/schedule_provider.dart';
import 'package:provider/provider.dart';

import '../model/appoinment_model.dart';
import '../service/db_server_appointment.dart';

class AppointmentBottomSheet extends StatelessWidget {

  AppointmentBottomSheet({super.key});

  final GlobalKey<FormState> formKey = GlobalKey();

  String? date;
  String? startTime;
  String? endTime;
  String? hospital;
  String? doctorName;

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = context.watch<ScheduleProvider>();
    final selectedDay = scheduleProvider.selectedDate;

    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    initializeDateFormatting('ko_KR');
    String formattedDate = DateFormat('yyyy-MM-dd(E)', 'ko_KR').format(selectedDay);
    date = formattedDate;

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
            padding: EdgeInsets.fromLTRB(20, 25, 20, bottomInset),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('진료',
                  style: TextStyle(
                    color: secondaryColor3,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.1
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(formattedDate,
                  style: const TextStyle(
                    color: typographyGray3,
                    fontSize: 14,
                    letterSpacing: -0.1
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                AppointmentTextField(
                  onSavedStartTime: (String? val) {startTime = val!;},
                  onSavedEndTime: (String? val) {endTime = val!;},
                  onSavedHospital: (String? val) {hospital = val!;},
                  onSavedDoctor: (String? val) {doctorName = val;},
                  startTimeValidator: timeValidator,
                  endTimeValidator: timeValidator,
                  hospitalValidator: hospitalValidator,
                  doctorValidator: doctorValidator,
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
                    child: const Text('진료 일정 등록하기'),
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
    if(formKey.currentState!.validate()) {  // 폼 검증
      formKey.currentState!.save();  // 폼 저장

      context.read<ScheduleProvider>().createAppointment(
          appointment: Appointment(
            id: 0,
            date: date!,
            startTime: startTime!,
              endTime: endTime!,
              hospital: hospital!,
              doctorName: doctorName)
      );

      print('-----data input-----');
      print('date : $date');
      print('startTime : $startTime');
      print('endTime : $endTime');
      print('hospital : $hospital');
      print('doctorName : $doctorName');

      Navigator.pop(context);
    } else {
    }
  }
}

String? timeValidator(String? val) {
  if(val == null || val.isEmpty) {
    return '시간을 입력하세요';
  }
  return null;
}
String? hospitalValidator(String? val) {
  if(val == null || val.isEmpty) {
    return '병원 이름을 입력하세요';
  }
  return null;
}
String? doctorValidator(String? val) {
  if(val!.length > 10) {
    return '10글자 이내로 입력하세요';
  }
  return null;
}