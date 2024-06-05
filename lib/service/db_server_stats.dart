import 'package:mindlog_app/model/record_model.dart';
import 'package:dio/dio.dart';

import '../const/server.dart';

class StatsRepository {
  final dio = Dio();
  final String serverIP_stats = 'http://$URL_NOW:3333/api/v1/stats';

  Future<List<String>> getKeyword() async {
    var serverUrl = '$serverIP_stats/keyword/';

    final response = await dio.get(serverUrl);

    if (response.statusCode == 200) {
      print("Keyword loaded successfully");
      return response.data;
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  }

  Future<List<String>> getNegativeSituation() async {
    var serverUrl = '$serverIP_stats/negative';

    final response = await dio.get(serverUrl);

    if (response.statusCode == 200) {
      print("Negative situation loaded successfully");
      return response.data;
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  }

  Future<List<String>> getPositiveSituation() async {
    var serverUrl = '$serverIP_stats/positive';

    final response = await dio.get(serverUrl);

    if (response.statusCode == 200) {
      print("Positive situation loaded successfully");
      return response.data;
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  }
}