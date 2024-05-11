import 'package:flutter/material.dart';

import '../model/appoinment_model.dart';

class appointmentRecord extends StatefulWidget {
  final Appointment appointment;

  const appointmentRecord({super.key, required this.appointment});

  @override
  State<appointmentRecord> createState() => _appointmentRecordState();
}

class _appointmentRecordState extends State<appointmentRecord> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('아직 녹음을 하지 않았어요'),
            Image.asset('assets/icons/record_button.png')
          ],
        ),
      ),
    );
  }
}
