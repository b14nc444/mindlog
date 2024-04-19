class Appointment {
  //final Long? id;
  final String? date;  // 이거 date로 바꿔야됨
  final String? startTime;
  final String? endTime;
  final String? hospital;
  final String? doctorName;

  Appointment({required this.date, required this.startTime, required this.endTime, required this.hospital, required this.doctorName,});

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      //id: json['id'],
      date: json['date'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      hospital: json['hospital'],
      doctorName: json['doctorName'],);
  }
  Map<String, dynamic> toJson() => {
    //'id': id,
    'date': date,
    'startTime': startTime,
    'endTime': endTime,
    'hospital' : hospital,
    'doctorName': doctorName,
  };
}