import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mindlog_app/service/db_server_appointment.dart';
import 'package:mindlog_app/model/appoinment_model.dart';
import 'package:mindlog_app/model/record_model.dart';

class ScheduleProvider extends ChangeNotifier {
  final AppointmentRepository repository;

  DateTime selectedDate = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String formattedDate = '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}';

  Map<String, List<Appointment>> cache = {};
  List<Appointment> _allAppointments = [];

  List<Appointment> get allAppointments => _allAppointments;

  ScheduleProvider({required this.repository}) : super() {
    getAppointmentByDate(date: selectedDate);
  }

  //CRUD
  void getAppointmentByDate({required DateTime date}) async {
    String formattedDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    final response = await repository.getAppointmentsByDate(formattedDate);
    // cache[formattedDate] = response;

    cache.update(formattedDate, (value) => response, ifAbsent: () => response);
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

  void getAppointmentsAll() async {
    try {
      final response = await repository.getAppointmentsAll();
      _allAppointments = response;
      notifyListeners();
    } catch (e) {
      throw Exception('failed to load mindlogs');
    }
  }

  void createAppointment({required Appointment appointment}) async {
    final date = appointment.date;
    String formattedDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    final savedAppointment = await repository.createAppointment(appointment);

    print('requested');

    cache.update(formattedDate, (value) => [
      ...value,
      appointment.copyWith(id: savedAppointment)
    ]..sort(
        (a, b) => a.startTime!.compareTo(b.startTime!)
    ),
    ifAbsent: () => [appointment]
    );
    notifyListeners();
  }

  void deleteAppointment({required int id, required DateTime date}) async {
    String formattedDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    try {
      final response = await repository.deleteAppointment(id);
      cache.update(formattedDate, (value) => value.where((e) => e.id != id).toList(),
          ifAbsent: () => []);
      notifyListeners();
        } catch (e) {
      print("Failed to delete appointment: $e");
    }
  }

  void updateAppointment({required int id, required Appointment appointment}) async {
    final date = appointment.date;
    String formattedDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    final response = await repository.updateAppointment(id, appointment);

    cache.update(formattedDate, (value) =>
    [
      ...value,
      appointment.copyWith(id: id)
    ]
      ..sort(
              (a, b) => a.date!.compareTo(b.date!)
      ),
        ifAbsent: () => [appointment]
    );
    notifyListeners();
  }
  
  void updateAppointmentMemo({required int id, required String memo}) async {
    Appointment existingAppointment = await repository.getAppointmentById(id);

    // 수정된 예약 정보 생성
    Appointment updatedAppointment = Appointment(
      id: existingAppointment.id,
      date: existingAppointment.date,
      startTime: existingAppointment.startTime, // 수정된 시작 시간
      endTime: existingAppointment.endTime, // 수정된 종료 시간
      doctorName: existingAppointment.doctorName,
      hospital: existingAppointment.hospital,
      memo: memo
    );

    final response = await repository.updateAppointment(id, updatedAppointment);
    notifyListeners();
  }

  void updateAppointmentRecord({required int appointmentId, required int recordId}) async {
    Appointment existingAppointment = await repository.getAppointmentById(
        appointmentId);

    // 수정된 예약 정보 생성
    Appointment updatedAppointment = Appointment(
      id: existingAppointment.id,
      date: existingAppointment.date,
      startTime: existingAppointment.startTime,
      endTime: existingAppointment.endTime,
      doctorName: existingAppointment.doctorName,
      hospital: existingAppointment.hospital,
      memo: existingAppointment.memo,
      record_id: recordId,
    );

    final response = await repository.updateAppointment(appointmentId, updatedAppointment);
    notifyListeners();
  }

  void changeSelectedDate({required DateTime date,}) {
    selectedDate = DateTime.utc(date.year, date.month, date.day);
    // formattedDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    formattedDate = DateFormat('yyyy-MM-dd', 'ko_KR').format(date);
    notifyListeners();
  }
}
