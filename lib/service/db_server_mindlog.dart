import 'package:flutter/material.dart';
import '../model/mindlog_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String serverIP_mindlog = 'http://112.168.203.141:3333/api/v1/mindlog';

//감정기록 추가
Future<int> createMindlog(BuildContext context, Mindlog mindlog) async {
  var serverUrl = Uri.parse(serverIP_mindlog);

  final response = await http.post(serverUrl,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(mindlog.toJson()),
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> responseData = json.decode(response.body);
    int mindlogId = responseData['id']; // 서버로부터 받은 진료 일정의 ID

    print('New mindlog added with ID: $mindlogId');
    return mindlogId;

  } else {
    throw Exception("Failed to send data2: ${response.statusCode}");
  }
}
  // try {
  //   final response = await http.post(serverUrl,
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(mindlog.toJson()),
  //   );
  //
  //   if (response.statusCode != 200) {
  //     throw Exception("Failed to send data2: ${response.statusCode}");
  //   } else {
  //     //성공 시 콘솔 출력
  //     print("Mindlog Data sent successfully");
  //   }
  // } catch (e) {
  //   print("Failed to send data1: ${e}");
  // }

//삭제
Future<void> deleteMindlog(BuildContext context, int mindlogId) async {
  var serverUrl = Uri.parse('$serverIP_mindlog/$mindlogId');

  try {
    final response = await http.delete(serverUrl);

    if (response.statusCode == 200) {
      print("Mindlog Data deleted successfully");
    } else {
      throw Exception("Failed to delete data: ${response.statusCode}");
    }
  } catch (e) {
    print("Failed to delete data: $e");
  }
}

//수정
Future<void> updateMindlog(BuildContext context, int mindlogId, Mindlog mindlog) async {
  var serverUrl = Uri.parse('$serverIP_mindlog/$mindlogId');

  try {
    final response = await http.put(serverUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(mindlog.toJson()),
    );

    if (response.statusCode == 200) {
      print("Mindlog Data updated successfully");
    } else {
      throw Exception("Failed to send data2: ${response.statusCode}");
    }
  } catch (e) {
    print("Failed to send data1: $e");

  }
}

//날짜별조회
Future<void> getMindlogByDate(BuildContext context, String mindlogDate) async {
  var serverUrl = Uri.parse('$serverIP_mindlog/by-date/$mindlogDate');

  try {
    final response = await http.get(serverUrl);

    if (response.statusCode == 200) {
      List<dynamic> responseData = json.decode(response.body);
      List<Mindlog> mindlogs = responseData.map((data) => Mindlog.fromJson(data)).toList();
      for (var mindlog in mindlogs) {
        print('Date: ${mindlog.date}');
        print('Mood Color: ${mindlog.moodColor}');
        print('Title: ${mindlog.title}');
        print('Emotion Record: ${mindlog.emotionRecord}');
        print('Event Record: ${mindlog.eventRecord}');
        print('Question Record: ${mindlog.questionRecord}');
        print('------------------------');
      }
      print("Mindlog Data received successfully");
    } else {
      throw Exception("Failed to loaded data: ${response.statusCode}");
    }
  } catch (e) {
    print("Failed to received data: $e");
  }
}

//id별조회
Future<Mindlog> getMindlogById(BuildContext context, int mindlogId) async {
  var serverUrl = Uri.parse('$serverIP_mindlog/$mindlogId');

  final response = await http.get(serverUrl);

  if (response.statusCode == 200) {
    print("Mindlog Data loaded successfully");

    dynamic responseData = json.decode(response.body);  // 응답 데이터를 JSON으로 디코딩
    return Mindlog.fromJson(responseData); // Appointment 모델로 변환하여 반환
  } else {
    throw Exception("Failed to load data: ${response.statusCode}");
  }
}