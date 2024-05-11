import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mindlog_app/service/db_server_appointment.dart';
import 'package:mindlog_app/model/appoinment_model.dart';

class ScheduleProvider extends ChangeNotifier {
  final AppointmentRepository repository;

  DateTime selectedDate = DateTime.now();
  // String formattedDate = DateTime.now().toIso8601String();
  Map<String, List<Appointment>> cache = {};

  ScheduleProvider({required this.repository}) : super() {
    getAppointmentByDate(date: selectedDate);
  }

  //CRUD
  void getAppointmentByDate({required DateTime date}) async {
    date = DateTime.parse(date.toIso8601String().split('T')[0]);
    final response = await repository.getAppointmentByDate(date);

    cache.update(date.toIso8601String(), (value) => response, ifAbsent: () => response);
    notifyListeners();
    print(cache);
  }

  void getAppointmentById({required int id}) async {
    try {
      final response = await repository.getAppointmentById(id);
      notifyListeners();
        } catch (e) {
      throw Exception('failed to load appointment');
    }

  }

  void createAppointment({required Appointment appointment}) async {
    final targetDate = appointment.date.toIso8601String();
    final savedAppointment = await repository.createAppointment(appointment);

    print('requested');

    cache.update(targetDate, (value) => [
      ...value,
      appointment.copyWith(id: savedAppointment)
    ]..sort(
        (a, b) => a.startTime.compareTo(b.startTime)
    ),
    ifAbsent: () => [appointment]
    );
  }

  void deleteAppointment({required int id, required DateTime date}) async {
    try {
      final response = await repository.deleteAppointment(id);
      cache.update(date.toIso8601String(), (value) => value.where((e) => e.id != id).toList(),
          ifAbsent: () => []);
      notifyListeners();
        } catch (e) {
      print("Failed to delete appointment: $e");
    }
  }

  void updateAppointment({required int id, required Appointment appointment}) async {
    final targetDate = appointment.date.toIso8601String();
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
    // formattedDate = DateFormat('yyyy-MM-dd(E)', 'ko_KR').format(date);
    notifyListeners();
  }
}
