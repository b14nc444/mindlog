class Record {
  final int id;
  final String filePath;
  final String? summary;

  Record({required this.id, required this.filePath, this.summary});

  Record.fromJson(Map<String, dynamic> json) :
        id = json['id'],
        filePath = json['filePath'],
        summary = json['summary'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'filePath': filePath,
      'summary' : summary
    };
  }

  Record copyWith({
    int? id,
    String? filePath,
    String? summary,
  }) {
    return Record(
        id: id ?? this.id,
        filePath: filePath ?? this.filePath,
        summary: summary ?? this.summary,
    );
  }
}

