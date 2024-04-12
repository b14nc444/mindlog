import 'package:flutter/material.dart';
import 'package:mindlog_app/component/appointment_textfield.dart';
import 'package:mindlog_app/const/visual.dart';

class AppointmentBottomSheet extends StatefulWidget {
  const AppointmentBottomSheet({super.key});

  @override
  State<AppointmentBottomSheet> createState() => _AppointmentBottomSheetState();
}

class _AppointmentBottomSheetState extends State<AppointmentBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 470,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
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
      child: const Padding(
        padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('진료',
              style: TextStyle(
                color: SECONDARY_COLOR_3,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.1
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text('2024-04-15(토)',
              style: TextStyle(
                color: TYPOGRAPHY_GRAY_3,
                fontSize: 14,
                letterSpacing: -0.1
              ),
            ),
            SizedBox(
              height: 24,
            ),
            AppointmentTextField(),
            SizedBox(
              height: 50,
              child: Center(
                child: Text('진료 일정 등록하기',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
