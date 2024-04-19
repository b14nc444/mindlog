import 'package:flutter/material.dart';
import 'package:mindlog_app/model/appoinment_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String serverIP_appointment = 'http://112.168.203.141:3333/api/v1/appointment';

//진료 추가
Future<int> createAppointment(BuildContext context, Appointment appointment) async {
  var serverUrl = Uri.parse(serverIP_appointment);

  final response = await http.post(serverUrl,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(appointment.toJson()),
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> responseData = json.decode(response.body);
    int appointmentId = responseData['id']; // 서버로부터 받은 진료 일정의 ID

    print('New mindlog added with ID: $appointmentId');
    return appointmentId;

  } else {
    throw Exception("Failed to send data2: ${response.statusCode}");
  }
}

//삭제
Future<void> deleteAppointment(BuildContext context, int appointmentId) async {
  var serverUrl = Uri.parse('${serverIP_appointment}/${appointmentId}');

  try {
    final response = await http.delete(serverUrl);

    if (response.statusCode == 200) {
      print("Appointment Data deleted successfully");
    } else {
      throw Exception("Failed to delete data: ${response.statusCode}");
    }
  } catch (e) {
    print("Failed to delete data: $e");
  }
}

Future<void> updateAppointment(BuildContext context, int appointmentId, Appointment appointment) async {
  var serverUrl = Uri.parse('${serverIP_appointment}/${appointmentId}');

  try {
    final response = await http.put(serverUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(appointment.toJson()),
    );

    if (response.statusCode == 200) {
      print("Appointment Data updated successfully");
    } else {
      throw Exception("Failed to send data2: ${response.statusCode}");
    }
  } catch (e) {
    print("Failed to send data1: ${e}");

  }
}

//날짜별조회
Future<void> getAppointmentByDate(BuildContext context, String appointmentDate) async {
  var serverUrl = Uri.parse('${serverIP_appointment}/by-date/${appointmentDate}');

  try {
    final response = await http.get(serverUrl);

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      List<Appointment> appointments = responseData.map((data) => Appointment.fromJson(data)).toList();
      for (var appointment in appointments) {
        print('Date: ${appointment.date}');
        print('Start Time: ${appointment.startTime}');
        print('End Time: ${appointment.endTime}');
        print('Hospital: ${appointment.hospital}');
        print('Doctor: ${appointment.doctorName}');
        print('------------------------');
      }
      print("Appointment Data received successfully");
    } else {
      throw Exception("Failed to loaded data: ${response.statusCode}");
    }
  } catch (e) {
    print("Failed to received data: $e");
  }
}

//id별조회
Future<Appointment> getAppointmentById(BuildContext context, int appointmentId) async {
  var serverUrl = Uri.parse('${serverIP_appointment}/${appointmentId}');

  final response = await http.get(serverUrl);

  if (response.statusCode == 200) {
    print("Appointment Data loaded successfully");

    dynamic responseData = json.decode(response.body);  // 응답 데이터를 JSON으로 디코딩
    return Appointment.fromJson(responseData); // Appointment 모델로 변환하여 반환
  } else {
    throw Exception("Failed to load data: ${response.statusCode}");
  }
}