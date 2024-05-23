import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mindlog_app/model/record_model.dart';
import 'package:mindlog_app/service/db_server_record.dart';

Record? _record = null;

class RecordProvider extends ChangeNotifier {
  final RecordRepository repository;

  // DateTime selectedDate = DateTime.now();
  // Map<String, List<Record>> cache = {};

  RecordProvider({required this.repository}) : super() {}

  //CRUD
  void getRecordById({required int id}) async {
    try {
      final response = await repository.getRecordById(id);
      _record = response;
      notifyListeners();
    } catch (e) {
      _record = null;
      throw Exception('failed to load record');
    }
  }

  Record? get record => _record;

  void createRecord({required Record record}) async {
    // final targetAppointment = record.appointmentId;
    try {
      final savedRecord = await repository.createRecord(record);
      print('Requested');
    } catch (e) {
      print('Failed to create record: $e');
      // 필요에 따라 예외 처리를 추가하세요.
    }
    //
    // cache.update(targetDate, (value) => [
    //   ...value,
    //   appointment.copyWith(id: savedAppointment)
    // ]..sort(
    //         (a, b) => a.startTime.compareTo(b.startTime)
    // ),
    //     ifAbsent: () => [appointment]
    // );
  }
}
