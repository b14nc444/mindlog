import 'package:intl/intl.dart';
import 'package:mindlog_app/model/record_model.dart';

class Appointment {
  final int id;
  final DateTime date;  // 이거 date로 바꿔야됨
  final String startTime;
  final String endTime;
  final String hospital;
  final String? doctorName;
  final String? memo;
  final int? record_id;

  Appointment({required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.hospital,
    this.doctorName,
    this.memo,
    this.record_id,});

  Appointment.fromJson(Map<String, dynamic> json) :
      id = json['id'],
      date = DateTime.parse(json['date']),
      startTime = DateFormat('HH:mm').format(DateFormat('HH:mm:ss').parse(json['startTime'])),
      endTime = DateFormat('HH:mm').format(DateFormat('HH:mm:ss').parse(json['endTime'])),
      hospital = json['hospital'],
      doctorName = json['doctorName'],
      memo = json['memo'],
      record_id = json['record_id'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': DateFormat('yyyy-MM-dd', 'ko_KR').format(date),
      'startTime': startTime,
      'endTime': endTime,
      'hospital' : hospital,
      'doctorName': doctorName,
      'memo': memo,
      'record_id': record_id,
    };
  }

  Appointment copyWith({
    int? id,
    DateTime? date,
    String? startTime,
    String? endTime,
    String? hospital,
    String? doctorName,
    String? memo,
    int? record_id,
  }) {
    return Appointment(
      id: id ?? this.id,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      hospital: hospital ?? this.hospital,
      doctorName: doctorName ?? this.doctorName,
      memo: memo ?? this.memo,
      record_id: record_id ?? this.record_id,
    );

  }
}

