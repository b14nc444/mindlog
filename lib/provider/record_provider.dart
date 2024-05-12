import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mindlog_app/model/record_model.dart';
import 'package:mindlog_app/service/db_server_record.dart';

Record? _record;

class RecordProvider extends ChangeNotifier {
  final RecordRepository repository;

  // DateTime selectedDate = DateTime.now();
  Map<String, List<Record>> cache = {};

  RecordProvider({required this.repository}) : super() {}

  //CRUD
  void getRecordById({required int id}) async {
    try {
      final response = await repository.getRecordById(id);
      _record = response;
      notifyListeners();
    } catch (e) {
      throw Exception('failed to load appointment');
    }
  }

  Record? get record => _record;

  void createRecord({required Record record}) async {
    final targetAppointment = record.appointmentId;
    final savedRecord = await repository.createRecord(record);
    print('requested');
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
