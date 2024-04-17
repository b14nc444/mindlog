import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mindlog_app/component/appointment_textfield.dart';
import 'package:mindlog_app/component/hide_keyboard_on_tap.dart';
import 'package:mindlog_app/const/visual.dart';

import '../model/appoinment_model.dart';
import '../service/db_server.dart';

class AppointmentBottomSheet extends StatefulWidget {

  final DateTime selectedDate;

  const AppointmentBottomSheet({super.key, required this.selectedDate});

  @override
  State<AppointmentBottomSheet> createState() => _AppointmentBottomSheetState();
}

class _AppointmentBottomSheetState extends State<AppointmentBottomSheet> {

  final GlobalKey<FormState> formKey = GlobalKey();

  String? date;
  String? startTime;
  String? endTime;
  String? hospital;
  String? doctor;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    DateTime selectedDate = widget.selectedDate;

    initializeDateFormatting('ko_KR');
    String formattedDate = DateFormat('yyyy-MM-dd(E)', 'ko_KR').format(selectedDate);
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
                offset: Offset(0, 1), // Offset
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
                    color: SECONDARY_COLOR_3,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.1
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Text('$formattedDate',
                  style: TextStyle(
                    color: TYPOGRAPHY_GRAY_3,
                    fontSize: 14,
                    letterSpacing: -0.1
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                AppointmentTextField(
                  StartTimeSetter: (String? val) {startTime = val;},
                  EndTimeSetter: (String? val) {endTime = val;},
                  HospitalSetter: (String? val) {hospital = val;},
                  DoctorSetter: (String? val) {doctor = val;},
                  validator: contentValidator,
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 50,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onCreateButtonPressed();
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR,
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text('진료 일정 등록하기'),
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }

  void onCreateButtonPressed() {

    createAppointment(context, Appointment(
      date: date,
      startTime: startTime,
      endTime: endTime,
      doctor: doctor,
      hospital: hospital,
    ));

    if(formKey.currentState!.validate()) {  // 폼 검증
    formKey.currentState!.save();  // 폼 저장
      print('date : $date');
      print('start time : $startTime');
      print('end time : $endTime');
      print('hospital : $hospital');
      print('doctor: $doctor');
    } else {
      print("null can't exist");
    }
  }
}

String? contentValidator(String? val) {
  if(val == null || val.length == 0) {
    return 'insert the content';
  }
  return null;
}