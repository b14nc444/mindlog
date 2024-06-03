import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../const/visual.dart';
import '../model/appoinment_model.dart';
import '../screen/appointment_screen.dart';

class timelineAppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const timelineAppointmentCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('M.d', 'ko_KR').format(appointment.date!);
    String formattedStartTime = appointment.startTime;
    String formattedEndTime = appointment.endTime;
    if (formattedStartTime.startsWith('0')) {
      formattedStartTime = appointment.startTime.substring(1);
    }
    if (formattedEndTime.startsWith('0')) {
      formattedEndTime = appointment.endTime.substring(1);
    }

    return Column(
      children: [
        SizedBox(height: 10,),
        Row(
          children: [
            Column(
              children: [
                Text(formattedDate, style: TextStyle(
                  color: basicBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),),
                Text(formattedStartTime, style: TextStyle(
                  color: typographyGray1,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),),
              ],
            ),
            SizedBox(width: 10,),
            const Icon(Icons.square, color: Color(0xffD1D1D1), size: 16,),
            SizedBox(width: 10,),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => appointmentScreen(
                        appointment: appointment,)
                      )
                  );
                },
                child: Container(
                  width: 250,
                  height: 47,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: ShapeDecoration(
                    color: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x2813203E),
                        blurRadius: 17,
                        offset: Offset(0, 7),
                        spreadRadius: -1,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Text(
                              '진료',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 14),
                            Text(
                              '$formattedStartTime - $formattedEndTime',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.15,
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios_rounded, color: Colors.white,)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20,),
      ],
    );
  }
}
