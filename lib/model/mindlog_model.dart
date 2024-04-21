class Mindlog {
  //final Long? id;
  final String? date;  // 이거 date로 바꿔야됨
  final String? mood;
  final String? moodColor;
  final String? title;
  final String? emotionRecord;
  final String? eventRecord;
  final String? questionRecord;

  Mindlog({required this.date,
    required this.mood,
    required this.moodColor,
    required this.title,
    required this.emotionRecord,
    required this.eventRecord,
    required this.questionRecord,});

  factory Mindlog.fromJson(Map<String, dynamic> json) {
    return Mindlog(
      //id: json['id'],
        date: json['date'],
        mood: json['mood'],
        moodColor: json['moodColor'],
        title: json['title'],
        emotionRecord: json['emotionRecord'],
        eventRecord: json['eventRecord'],
        questionRecord: json['questionRecord']);
  }
  Map<String, dynamic> toJson() => {
    //'id': id,
    'date': date,
    'mood': mood,
    'moodColor': moodColor,
    'title': title,
    'emotionRecord': emotionRecord,
    'eventRecord': eventRecord,
    'questionRecord' : questionRecord,
  };
}