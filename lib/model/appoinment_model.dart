import 'dart:ffi';

class Appointment {
  //final Long? id;
  final String? date;  // 이거 date로 바꿔야됨
  final String? startTime;
  final String? endTime;
  final String? doctor;
  final String? hospital;

  Appointment({required this.date, required this.startTime, required this.endTime, required this.doctor, required this.hospital,});

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
        //id: json['id'],
        date: json['date'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        doctor: json['doctorName'],
        hospital: json['hospital']);
  }
  Map<String, dynamic> toJson() => {
    //'id': id,
    'date': date,
    'startTime': startTime,
    'endTime': endTime,
    'doctorName': doctor,
    'hospital' : hospital
  };
}