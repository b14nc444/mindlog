import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:mindlog_app/model/record_model.dart';
import 'package:mindlog_app/service/db_server_record.dart';

import '../service/db_server_stats.dart';

class StatsProvider extends ChangeNotifier {
  final StatsRepository repository;

  List<String> _keywords = [];
  List<String> _negativeSituations = [];
  List<String> _positiveSituations = [];

  List<String> get keywords => _keywords;
  List<String> get negativeSituations => _negativeSituations;
  List<String> get positiveSituations => _positiveSituations;

  StatsProvider({required this.repository}) : super() {}

  //상위 키워드 조회
  void getNegativeSituation() async {
    try {
      final response = await repository.getNegativeSituation();
      _negativeSituations = response;
      notifyListeners();
      print(_negativeSituations);
    } catch (e) {
      throw Exception('failed to load negative situations');
    }
  }

  void getPositiveSituation() async {
    try {
      final response = await repository.getPositiveSituation();
      _positiveSituations = response;
      notifyListeners();
      print(_positiveSituations);
    } catch (e) {
      throw Exception('failed to load positive situations');
    }
  }

  void getKeyword() async {
    try {
      final response = await repository.getKeyword();
      _keywords = response;
      notifyListeners();
      print(_keywords);
    } catch (e) {
      throw Exception('failed to load keywords');
    }
  }
}
