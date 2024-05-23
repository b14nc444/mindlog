import 'package:dio/dio.dart';
import '../const/server.dart';
import '../model/mindlog_model.dart';

class MindlogRepository {
  final dio = Dio();
  final String serverIP_mindlog = 'http://$URL_NOW:3333/api/v1/mindlog';

  //감정기록 추가
  Future<int> createMindlog(Mindlog mindlog) async {
    var serverUrl = serverIP_mindlog;

    final json = mindlog.toJson();
    try {
      final response = await dio.post(serverUrl, data: json);

      if (response.statusCode == 200) {
        int mindlogId = response.data?['id'];
        print('New mindlog added with ID: $mindlogId');
        return mindlogId;
      } else {
        // 서버 응답 코드가 200이 아닌 경우 처리
        print('HTTP status code: ${response.statusCode}');
        print('Response data: ${response.data}');
        throw Exception('Failed to create mindlog: ${response.statusMessage}');
      }
    } on DioError catch (e) {
      // DioError 처리
      if (e.response != null) {
        print('HTTP status code: ${e.response?.statusCode}');
        print('Response data: ${e.response?.data}');
        throw Exception('Failed to create mindlog: ${e.response?.statusMessage}');
      } else {
        print('Error: ${e.error}');
        print('Error message: ${e.message}');
        throw Exception('Failed to create mindlog: ${e.message}');
      }
    } catch (e) {
      // 다른 예외 처리
      print('Error: $e');
      throw Exception('Failed to create mindlog: $e');
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
  Future<List<Mindlog>> getMindlogByDate(String date) async {
    var serverUrl = '$serverIP_mindlog/by-date/$date';

    try {
      final response = await dio.get(serverUrl, queryParameters: {});

      if (response.statusCode == 200) {
        List<Mindlog> mindlogs = response.data.map<Mindlog>(
                (x) => Mindlog.fromJson(x)
        ).toList();
        // for (var mindlog in mindlogs) {
        //   print('Id: ${mindlog.id}');
        //   print('Date: ${mindlog.date}');
        //   print('Time: ${mindlog.time}');
        //   print('Mood Color: ${mindlog.moodColor}');
        //   print('Title: ${mindlog.title}');
        //   print('Emotion Record: ${mindlog.emotionRecord}');
        //   print('Event Record: ${mindlog.eventRecord}');
        //   print('Question Record: ${mindlog.questionRecord}');
        //   print('------------------------');
        // }
        print("Mindlog Data received successfully");
        return mindlogs;

      } else {
        throw Exception("Failed to loaded data: ${response.statusCode}");
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 400) {
          // 400 Bad Request 에러 처리
          throw Exception("Bad Request: ${e.response?.data}");
        } else {
          // 다른 DioException 처리
          throw Exception("Failed to received data: $e");
        }
      } else {
        // 다른 예외 처리
        throw Exception("Failed to received data: $e");
      }
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

  //전체조회
  Future<Mindlog> getMindlogAll() async {
    var serverUrl = '$serverIP_mindlog';

    final response = await dio.get(serverUrl);

    if (response.statusCode == 200) {
      print("Mindlog Data loaded successfully");
      return Mindlog.fromJson(response.data);
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  }
}