import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mindlog_app/component/appointment_textfield.dart';
import 'package:mindlog_app/const/visual.dart';

class AppointmentBottomSheet extends StatefulWidget {

  final DateTime selectedDate;

  const AppointmentBottomSheet({super.key, required this.selectedDate});

  @override
  State<AppointmentBottomSheet> createState() => _AppointmentBottomSheetState();
}

class _AppointmentBottomSheetState extends State<AppointmentBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    DateTime selectedDate = widget.selectedDate;

    initializeDateFormatting('ko_KR');
    String formattedDate = DateFormat('yyyy-MM-dd(E)', 'ko_KR').format(selectedDate);

    return Container(
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
            const AppointmentTextField(),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              child: FilledButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
    );
  }
}
