import 'package:flutter/material.dart';
import 'package:mindlog_app/model/appoinment_model.dart';
import 'package:mindlog_app/model/mindlog_model.dart';
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
      //성공 시 콘솔 출력
      print("Appointment Data sent successfully");
      print(appointment.startTime);
      print(appointment.date);
      print(appointment.startTime);
      print(appointment.endTime);
      print(appointment.hospital);
      print(appointment.doctor);
      Navigator.pop(context);
      //Get.to(const homeScreen());
    }
  } catch (e) {
    print("Failed to send data: ${e}");
  }
}

Future<void> createMindlog(BuildContext context, Mindlog mindlog) async {
  try {
    final response = await http.post(
      Uri.parse("http://mindbridge.com/api/v1/appointment"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(mindlog.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception("Failed to send data");
    } else {
      //성공 시 콘솔 출력
      print("Mindlog Data sent successfully");
      print(mindlog.date);
      print(mindlog.moodColor);
      print(mindlog.title);
      print(mindlog.emotionRecord);
      print(mindlog.eventRecord);
      print(mindlog.questionRecord);
      Navigator.pop(context);
      //Get.to(const homeScreen());
    }
  } catch (e) {
    print("Failed to send data: ${e}");
  }
}