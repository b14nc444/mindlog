import 'package:flutter/material.dart';

import '../const/visual.dart';

class appointmentList extends StatelessWidget {
  final String appointmentTime;
  final String hospital;
  final String doctor;

  const appointmentList({
    super.key, required this.appointmentTime, required this.hospital, required this.doctor
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: SizedBox(
            height: 90,
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 90,
                  decoration: const ShapeDecoration(
                    color: SECONDARY_COLOR_3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14, 12, 0, 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('진료',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(appointmentTime,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.15
                        ),
                      ),
                      SizedBox(
                        height: 1,
                      ),
                      Text(hospital + ' / ' + doctor,
                        style: const TextStyle(
                            color: BASIC_GRAY,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            letterSpacing: -0.15
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
