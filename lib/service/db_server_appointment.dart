import 'package:dio/dio.dart';
import 'package:mindlog_app/const/server.dart';
import 'package:mindlog_app/model/appoinment_model.dart';

class AppointmentRepository {
  final dio = Dio();
  final String serverIP_appointment = 'http://$URL_NOW:3333/api/v1/appointment';

  //진료 추가
  Future<int> createAppointment(Appointment appointment) async {
    var serverUrl = serverIP_appointment;

    final json = appointment.toJson();
    final response = await dio.post(serverUrl, data: json);
    print('waiting...');

    if (response.statusCode == 200) {
      int appointmentId = response.data?['id'];
      print('New appointment added with ID: $appointmentId');
      return appointmentId;

    } else {
      throw Exception("Failed to send data: ${response.statusCode}");
    }
  }

  //삭제
  Future<int> deleteAppointment(int appointmentId) async {
    var serverUrl = '$serverIP_appointment/$appointmentId';

    try {
      final response = await dio.delete(serverUrl);

      if (response.statusCode == 200) {
        int appointmentId = response.data?['id'];
        print('Appointment with this ID deleted: $appointmentId');
        return appointmentId;

      } else {
        throw Exception("Failed to delete data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to delete data: $e");
    }
  }

  Future<void> updateAppointment(int appointmentId, Appointment appointment) async {
    var serverUrl = '$serverIP_appointment/$appointmentId';

    try {
      final json = appointment.toJson();
      final response = await dio.put(serverUrl, data: json);

      if (response.statusCode == 200) {
        int appointmentId = response.data?['id'];
        print("Appointment Data with ID [$appointmentId] updated successfully");
      } else {
        throw Exception("Failed to send data2: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to send data1: $e");

    }
  }

  //날짜별조회
  Future<List<Appointment>> getAppointmentsByDate(String date) async {
    var serverUrl = '$serverIP_appointment/by-date/$date';

    try {
      final response = await dio.get(serverUrl, queryParameters: {});

      if (response.statusCode == 200) {
        List<Appointment> appointments = response.data.map<Appointment>(
                (x) => Appointment.fromJson(x)
        ).toList();
        print("Appointment Data received successfully");
        return appointments;

      } else {
        throw Exception("Failed to loaded data: ${response.statusCode}");
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          // 400 Bad Request 에러 처리
          throw Exception("Bad Request: ${e.response?.data}");
        } else {
          // 다른 DioException 처리
          throw Exception("Failed to received data: $e");
        }
      } else {
        // 다른 예외 처리
        throw Exception("Failed to received data: $e");
      }
    }
  }

  //id별조회
  Future<Appointment> getAppointmentById(int appointmentId) async {
    var serverUrl = '$serverIP_appointment/$appointmentId';

    final response = await dio.get(serverUrl);

    if (response.statusCode == 200) {
      print("Appointment Data loaded successfully");
      return Appointment.fromJson(response.data);
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  }

  //전체조회
  Future<List<Appointment>> getAppointmentsAll() async {
    var serverUrl = '$serverIP_appointment';

    final response = await dio.get(serverUrl);

    if (response.statusCode == 200) {
      List<Appointment> appointments = response.data.map<Appointment>(
              (x) => Appointment.fromJson(x)
      ).toList();
      print("Appointment Data received successfully");
      return appointments;

    } else {
      throw Exception("Failed to loaded data: ${response.statusCode}");
    }
  }
}