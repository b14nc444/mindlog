
class Mindlog {
  final int id;
  final String date;  // 이거 date로 바꿔야됨
  final List<String> mood;
  final int moodColor;
  final String title;
  final String emotionRecord;
  final String eventRecord;
  final String? questionRecord;

  Mindlog({
    required this.id,
    required this.date,
    required this.mood,
    required this.moodColor,
    required this.title,
    required this.emotionRecord,
    required this.eventRecord,
    required this.questionRecord,});

  Mindlog.fromJson(Map<String, dynamic> json) :
        id = json['id'],
        date = json['date'],
        mood = json['mood'],
        moodColor = json['moodColor'],
        title = json['title'],
        emotionRecord = json['emotionRecord'],
        eventRecord = json['eventRecord'],
        questionRecord = json['questionRecord'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date,
    'mood': mood,
    'moodColor': moodColor,
    'title': title,
    'emotionRecord': emotionRecord,
    'eventRecord': eventRecord,
    'questionRecord' : questionRecord,
  };

  Mindlog copyWith({
    int? id,
    String? date,
    List<String>? mood,
    int? moodColor,
    String? title,
    String? emotionRecord,
    String? eventRecord,
    String? questionRecord,
  }) {
    return Mindlog(
        id: id ?? this.id,
        date: date ?? this.date,
        mood: mood ?? this.mood,
        moodColor: moodColor ?? this.moodColor,
        title: title ?? this.title,
        emotionRecord: emotionRecord ?? this.emotionRecord,
        eventRecord: eventRecord ?? this.eventRecord,
        questionRecord: questionRecord ?? this.questionRecord,
    );
  }
}