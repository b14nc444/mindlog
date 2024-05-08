import 'package:dio/dio.dart';
import '../model/mindlog_model.dart';

class MindlogRepository {
  final dio = Dio();
  final String serverIP_mindlog = 'http://122.46.239.34:3333/api/v1/mindlog';

  //감정기록 추가
  Future<int> createMindlog(Mindlog mindlog) async {
    var serverUrl = serverIP_mindlog;

    final json = mindlog.toJson();
    final response = await dio.post(serverUrl, data: json);

    if (response.statusCode == 200) {
      int mindlogId = response.data?['id']; // 서버로부터 받은 진료 일정의 ID
      print('New mindlog added with ID: $mindlogId');
      return mindlogId;

    } else {
      throw Exception("Failed to send data: ${response.statusCode}");
    }
  }

  //삭제
  Future<int> deleteMindlog(int mindlogId) async {
    var serverUrl = '$serverIP_mindlog/$mindlogId';

    try {
      final response = await dio.delete(serverUrl, data: {'id': mindlogId});

      if (response.statusCode == 200) {
        int mindlogId = response.data?['id'];
        print('Mindlog with this ID deleted: $mindlogId');
        return mindlogId;
      } else {
        throw Exception("Failed to delete data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to delete data: $e");
    }
  }

  //수정
  Future<void> updateMindlog(int mindlogId, Mindlog mindlog) async {
    var serverUrl = '$serverIP_mindlog/$mindlogId';

    final json = mindlog.toJson();
    try {
      final response = await dio.put(serverUrl, data: json);

      if (response.statusCode == 200) {
        int mindlogId = response.data?['id'];
        print("Mindlog Data with ID [$mindlogId] updated successfully");
      } else {
        throw Exception("Failed to send data2: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to send data1: $e");

    }
  }

  //날짜별조회
  Future<List<Mindlog>> getMindlogByDate(String mindlogDate) async {
    var serverUrl = '$serverIP_mindlog/by-date/$mindlogDate';

    try {
      final response = await dio.get(serverUrl, queryParameters: {});

      if (response.statusCode == 200) {
        List<Mindlog> mindlogs = response.data.map<Mindlog>(
                (x) => Mindlog.fromJson(x)).toList();
        for (var mindlog in mindlogs) {
          print('Id: ${mindlog.id}');
          print('Date: ${mindlog.date}');
          print('Mood Color: ${mindlog.moodColor}');
          print('Title: ${mindlog.title}');
          print('Emotion Record: ${mindlog.emotionRecord}');
          print('Event Record: ${mindlog.eventRecord}');
          print('Question Record: ${mindlog.questionRecord}');
          print('------------------------');
        }
        print("Mindlog Data received successfully");
        return mindlogs;

      } else {
        throw Exception("Failed to loaded data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to received data: $e");
    }
  }

  //id별조회
  Future<Mindlog> getMindlogById(int mindlogId) async {
    var serverUrl = '$serverIP_mindlog/$mindlogId';

    final response = await dio.get(serverUrl);

    if (response.statusCode == 200) {
      print("Mindlog Data loaded successfully");
      return Mindlog.fromJson(response.data);
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  }
}