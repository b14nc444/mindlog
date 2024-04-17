import 'package:flutter/material.dart';
import 'package:mindlog_app/model/appoinment_model.dart';
import 'package:mindlog_app/screen/home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//진료 추가
Future<void> createAppointment(BuildContext context, Appointment appointment) async {
  try {
    final response = await http.post(
      Uri.parse("http://mindbridge.com/api/v1/appointment"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(appointment.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception("Failed to send data");
    } else {
      print("Appointment Data sent successfully");
      print('$appointment.startTime');
      print(appointment.hospital);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => homeScreen()), // 홈 페이지로 이동
      );
      //Get.to(const homeScreen());
    }
  } catch (e) {
    print("Failed to send data: ${e}");
  }
}