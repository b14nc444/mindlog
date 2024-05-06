import 'package:flutter/material.dart';
import 'package:mindlog_app/const/visual.dart';

import '../model/appoinment_model.dart';

class appointmentScreen extends StatefulWidget {
  final Appointment appointment;

  const appointmentScreen({super.key, required this.appointment});

  @override
  State<appointmentScreen> createState() => _appointmentScreenState();
}

class _appointmentScreenState extends State<appointmentScreen> {
  @override
  Widget build(BuildContext context) {
    Appointment appointment = widget.appointment;

    TextStyle textStyleTitle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: basicGray,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.today),
                    SizedBox(width: 4,),
                    Text(appointment.date,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor
                      ),
                    ),
                    Text('에 등록된 진료를',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: basicBlack
                      ),
                    ),
                  ],
                ),
                Text('기록합니다',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: basicBlack
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('진료 일정', style: textStyleTitle,),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Text('시간',
                              style: TextStyle(color: primaryColor),
                            ),
                            SizedBox(width: 30,),
                            Text('${appointment.startTime} - ${appointment.endTime}'),
                          ],
                        ),
                        Row(
                          children: [

                            Text('주치의',
                              style: TextStyle(color: primaryColor),
                            ),
                            SizedBox(width: 18,),
                            Text(
                              (appointment.doctorName != null) ? '${appointment.doctorName} (${appointment.hospital})' : '${appointment.hospital}',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('진료 내용', style: textStyleTitle),
                SizedBox(
                  height: 10,
                ),
                // appointment recording card
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('아직 녹음을 하지 않았어요'),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text('감정 기록 요약', style: textStyleTitle),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('아직 녹음을 하지 않았어요'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text('진료 메모', style: textStyleTitle),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
