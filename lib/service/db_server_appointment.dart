import 'package:dio/dio.dart';
import 'package:mindlog_app/model/appoinment_model.dart';

class AppointmentRepository {
  final dio = Dio();
  final String serverIP_appointment = 'http://122.46.239.34:3333/api/v1/appointment';

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
      final response = await dio.delete(serverUrl, data: {'id': appointmentId});

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

    final json = appointment.toJson();
    try {
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
  Future<List<Appointment>> getAppointmentByDate(String appointmentDate) async {
    var serverUrl = '$serverIP_appointment/by-date/$appointmentDate';

    try {
      final response = await dio.get(serverUrl, queryParameters: {});

      if (response.statusCode == 200) {
        List<Appointment> appointments = response.data.map<Appointment>(
                (x) => Appointment.fromJson(x)).toList();
        for (var appointment in appointments) {
          print('Id: ${appointment.id}');
          print('Date: ${appointment.date}');
          print('Start Time: ${appointment.startTime}');
          print('End Time: ${appointment.endTime}');
          print('Hospital: ${appointment.hospital}');
          print('Doctor: ${appointment.doctorName}');
          print('------------------------');
        }
        print("Appointment Data received successfully");
        return appointments;

      } else {
        throw Exception("Failed to loaded data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to received data: $e");
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
}