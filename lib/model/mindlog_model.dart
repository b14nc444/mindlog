
import 'package:intl/intl.dart';

class Mindlog {
  final int id;
  final DateTime date;
  final String time;
  final List<String> mood;
  final int moodColor;
  final String title;
  final String emotionRecord;
  final String eventRecord;
  final String? questionRecord;

  Mindlog({
    required this.id,
    required this.date,
    required this.time,
    required this.mood,
    required this.moodColor,
    required this.title,
    required this.emotionRecord,
    required this.eventRecord,
    required this.questionRecord,});

  Mindlog.fromJson(Map<String, dynamic> json) :
        id = json['id'],
        date = DateTime.parse(json['date']),
        time = DateFormat('HH:mm').format(DateFormat('HH:mm:ss').parse(json['time'])),
        mood = List<String>.from(json['moods']),
        moodColor = json['moodColor'],
        title = json['title'],
        emotionRecord = json['emotionRecord'],
        eventRecord = json['eventRecord'],
        questionRecord = json['questionRecord'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}',
    'time': time,
    'moods': mood.toList(),
    'moodColor': moodColor,
    'title': title,
    'emotionRecord': emotionRecord,
    'eventRecord': eventRecord,
    'questionRecord' : questionRecord,
  };

  Mindlog copyWith({
    int? id,
    DateTime? date,
    String? time,
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
        time: time ?? this.time,
        mood: mood ?? this.mood,
        moodColor: moodColor ?? this.moodColor,
        title: title ?? this.title,
        emotionRecord: emotionRecord ?? this.emotionRecord,
        eventRecord: eventRecord ?? this.eventRecord,
        questionRecord: questionRecord ?? this.questionRecord,
    );
  }
}