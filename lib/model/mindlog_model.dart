import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class Mindlog {
  //final Long? id;
  final String? date;  // 이거 date로 바꿔야됨
  final String? moodColor;
  final String? emotionRecord;
  final String? eventRecord;
  final String? questionRecord;

  Mindlog({required this.date, required this.moodColor, required this.emotionRecord, required this.eventRecord, required this.questionRecord,});

  factory Mindlog.fromJson(Map<String, dynamic> json) {
    return Mindlog(
      //id: json['id'],
        date: json['date'],
        moodColor: json['moodColor'],
        emotionRecord: json['emotionRecord'],
        eventRecord: json['eventRecord'],
        questionRecord: json['questionRecord']);
  }
  Map<String, dynamic> toJson() => {
    //'id': id,
    'date': date,
    'moodColor': moodColor,
    'emotionRecord': emotionRecord,
    'eventRecord': eventRecord,
    'questionRecord' : questionRecord,
  };
}