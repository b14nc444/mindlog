class Appointment {
  final int id;
  final DateTime date;  // 이거 date로 바꿔야됨
  final String startTime;
  final String endTime;
  final String hospital;
  final String? doctorName;

  Appointment({required this.id, required this.date, required this.startTime, required this.endTime, required this.hospital, required this.doctorName,});

  Appointment.fromJson(Map<String, dynamic> json) :
      id = json['id'],
      date = json['date'],
      startTime = json['startTime'],
      endTime = json['endTime'],
      hospital = json['hospital'],
      doctorName = json['doctorName'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'hospital' : hospital,
      'doctorName': doctorName,
    };
  }

  Appointment copyWith({
    int? id,
    DateTime? date,
    String? startTime,
    String? endTime,
    String? hospital,
    String? doctorName,
  }) {
    return Appointment(
        id: id ?? this.id,
        date: date ?? this.date,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        hospital: hospital ?? this.hospital,
        doctorName: doctorName ?? this.doctorName
    );

  }
}

