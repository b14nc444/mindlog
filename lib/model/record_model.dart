class Record {
  final int appointmentId;
  final String filePath;
  final String? summary;

  Record({required this.appointmentId, required this.filePath, this.summary});

  Record.fromJson(Map<String, dynamic> json) :
        appointmentId = json['appointment_id'],
        filePath = json['filePath'],
        summary = json['summary'];

  Map<String, dynamic> toJson() {
    return {
      'appointment_id': appointmentId,
      'filePath': filePath,
      'summary' : summary
    };
  }

  Record copyWith({
    int? appointmentId,
    String? filePath,
    String? summary,
  }) {
    return Record(
        appointmentId: appointmentId ?? this.appointmentId,
        filePath: filePath ?? this.filePath,
        summary: summary ?? this.summary,
    );
  }
}

