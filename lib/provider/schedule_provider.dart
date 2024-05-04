import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mindlog_app/service/db_server_appointment.dart';
import 'package:mindlog_app/model/appoinment_model.dart';

class ScheduleProvider extends ChangeNotifier {
  final AppointmentRepository repository;

  DateTime selectedDate = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd(E)', 'ko_KR').format(DateTime.now());
  Map<String, List<Appointment>> cache = {};

  ScheduleProvider({required this.repository}) : super() {
    getAppointmentByDate(date: formattedDate);
  }

  //CRUD
  void getAppointmentByDate({required String date}) async {
    final response = await repository.getAppointmentByDate(formattedDate);

    cache.update(date, (value) => response, ifAbsent: () => response);
    notifyListeners();
  }

  void getAppointmentById({required int id}) async {
    try {
      final response = await repository.getAppointmentById(id);
      if (response != null) {
        notifyListeners();
      } else {
        throw Exception('failed to load appointment: id error');
      }
    } catch (e) {
      throw Exception('failed to load appointment');
    }

  }

  void createAppointment({required Appointment appointment}) async {
    final targetDate = appointment.date;
    final savedAppointment = await repository.createAppointment(appointment);

    cache.update(targetDate, (value) => [
      ...value,
      appointment.copyWith(id: savedAppointment)
    ]..sort(
        (a, b) => a.startTime.compareTo(b.startTime)
    ),
    ifAbsent: () => [appointment]
    );
  }

  void deleteAppointment({required int id, required String date}) async {
    try {
      final response = await repository.deleteAppointment(id);
      if (response != null) {
        cache.update(date, (value) => value.where((e) => e.id != id).toList(),
            ifAbsent: () => []);
        notifyListeners();
      } else {
        throw Exception("Failed to delete appointment. Response was null.");
      }
    } catch (e) {
      print("Failed to delete appointment: $e");
    }
  }

  void updateAppointment({required int id, required Appointment appointment}) async {
    final targetDate = appointment.date;
    final response = await repository.updateAppointment(id, appointment);

    cache.update(targetDate, (value) =>
    [
      ...value,
      appointment.copyWith(id: id)
    ]
      ..sort(
              (a, b) => a.date.compareTo(b.date)
      ),
        ifAbsent: () => [appointment]
    );
    notifyListeners();
  }

  void changeSelectedDate({required DateTime date,}) {
    selectedDate = date;
    formattedDate = DateFormat('yyyy-MM-dd(E)', 'ko_KR').format(date);
    notifyListeners();
  }
}