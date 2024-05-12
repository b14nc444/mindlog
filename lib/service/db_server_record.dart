import 'package:mindlog_app/model/record_model.dart';
import 'package:dio/dio.dart';

import '../const/server.dart';

class RecordRepository {
  final dio = Dio();
  final String serverIP_record = 'http://$URL_NOW:3333/api/v1/record';

  //녹음 추가
  Future<int> createRecord(Record record) async {
    var serverUrl = serverIP_record;

    final json = record.toJson();
    final response = await dio.post(serverUrl, data: json);
    print('waiting...');

    if (response.statusCode == 200) {
      int appointmentId = response.data?['id'];
      print('New record added with ID: $appointmentId');
      return appointmentId;
    } else {
      throw Exception("Failed to send data: ${response.statusCode}");
    }
  }

  //id별조회
  Future<Record> getRecordById(int appointmentId) async {
    var serverUrl = '$serverIP_record/$appointmentId';

    final response = await dio.get(serverUrl);

    if (response.statusCode == 200) {
      print("Record Data loaded successfully");
      return Record.fromJson(response.data);
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  }
}

  //삭제
  // Future<int> deleteAppointment(int appointmentId) async {
  //   var serverUrl = '$serverIP_appointment/$appointmentId';
  //
  //   try {
  //     final response = await dio.delete(serverUrl, data: {'id': appointmentId});
  //
  //     if (response.statusCode == 200) {
  //       int appointmentId = response.data?['id'];
  //       print('Appointment with this ID deleted: $appointmentId');
  //       return appointmentId;
  //
  //     } else {
  //       throw Exception("Failed to delete data: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     throw Exception("Failed to delete data: $e");
  //   }
  // }
  //
  // Future<void> updateAppointment(int appointmentId, Appointment appointment) async {
  //   var serverUrl = '$serverIP_appointment/$appointmentId';
  //
  //   final json = appointment.toJson();
  //   try {
  //     final response = await dio.put(serverUrl, data: json);
  //
  //     if (response.statusCode == 200) {
  //       int appointmentId = response.data?['id'];
  //       print("Appointment Data with ID [$appointmentId] updated successfully");
  //     } else {
  //       throw Exception("Failed to send data2: ${response.statusCode}");
  //     }
  //   } catch (e) {
  //     throw Exception("Failed to send data1: $e");
  //
  //   }
  // }

// Future<void> uploadRecordedFileToServer() async {
//   // 녹음한 오디오 파일의 경로를 가져옴
//   String filePath = await getRecordedAudioFilePath();
//
//   // 파일을 열어 바이트로 읽음
//   File file = File(filePath);
//   List<int> fileBytes = await file.readAsBytes();
//
//   // 파일을 Base64로 인코딩
//   String base64String = base64Encode(fileBytes);
//
//   // JSON 객체 생성
//   Map<String, dynamic> requestBody = {
//     'fileName': 'recorded_audio.wav',
//     'fileData': base64String,
//   };
//
//   // 서버로 전송
//   var apiUrl = Uri.parse('https://example.com/upload');
//   var response = await http.post(
//     apiUrl,
//     headers: {'Content-Type': 'application/json'},
//     body: jsonEncode(requestBody),
//   );
//
//   // 응답 확인
//   if (response.statusCode == 200) {
//     print('파일 업로드 성공');
//   } else {
//     print('파일 업로드 실패: ${response.reasonPhrase}');
//   }
// }
