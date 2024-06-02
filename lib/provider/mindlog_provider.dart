import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/mindlog_model.dart';
import '../service/db_server_mindlog.dart';

class MindlogProvider with ChangeNotifier {
  List<Mindlog> _allMindlogs = [];
  Map<String, List<Mindlog>> _MindlogsByAppointmentId = {};

  List<Mindlog> get allMindlogs => _allMindlogs;

  final MindlogRepository repository;

  DateTime selectedDate = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  // String formattedDate = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day).toIso8601String();
  Map<String, List<Mindlog>> cache = {};

  MindlogProvider({required this.repository}) : super() {
    getMindlogByDate(date: selectedDate);
  }

  //CRUD
  void getMindlogByDate({required DateTime date}) async {
    String formattedDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    final response = await repository.getMindlogsByDate(formattedDate);

    cache.update(formattedDate, (value) => response, ifAbsent: () => response);
    notifyListeners();
    print(cache);
  }

  void getMindlogById({required int id}) async {
    try {
      final response = await repository.getMindlogById(id);
      notifyListeners();
        } catch (e) {
      throw Exception('failed to load mindlog');
    }
  }

  void getMindlogsAll() async {
    try {
      final response = await repository.getMindlogsAll();
      _allMindlogs = response;
      notifyListeners();
      print(_allMindlogs);
    } catch (e) {
      throw Exception('failed to load mindlogs');
    }
  }
  
  void getMindlogsByAppointmentId({required int appointmentId}) async {
    try {
      final response = await repository.getMindlogsByAppointmentId(appointmentId);
      notifyListeners();
    } catch (e) {
      throw Exception('failed to load mindlogs');
    }
  }
  
  void createMindlog({required Mindlog mindlog}) async {
    final targetDate = '${mindlog.date.year}-${mindlog.date.month.toString().padLeft(2, '0')}-${mindlog.date.day.toString().padLeft(2, '0')}';
    final savedMindlog = await repository.createMindlog(mindlog);

    print('requested');

    cache.update(targetDate, (value) =>
    [
      ...value,
      mindlog.copyWith(id: savedMindlog)
    ]
      ..sort(
              (a, b) => a.date.compareTo(b.date)
      ),
        ifAbsent: () => [mindlog]
    );
    notifyListeners();
  }

  void deleteMindlog({required int id, required DateTime date}) async {
    String formattedDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    try {
      final response = await repository.deleteMindlog(id);
      cache.update(date.toIso8601String(), (value) => value.where((e) => e.id != id).toList(),
          ifAbsent: () => []);
      notifyListeners();
        } catch (e) {
      print("Failed to delete appointment: $e");
    }
  }

  void updateMindlog({required int id, required Mindlog mindlog}) async {
    final targetDate = '${mindlog.date.year}-${mindlog.date.month.toString().padLeft(2, '0')}-${mindlog.date.day.toString().padLeft(2, '0')}';
    final response = await repository.updateMindlog(id, mindlog);

    cache.update(targetDate, (value) =>
    [
      ...value,
      mindlog.copyWith(id: id)
    ]
      ..sort(
              (a, b) => a.date.compareTo(b.date)
      ),
        ifAbsent: () => [mindlog]
    );
    notifyListeners();
  }

  List<MoodItem> moodItems = [
    MoodItem('섬뜩한', 1),
    MoodItem('죽을 것 같은', 1),
    MoodItem('조마조마한', 1),
    MoodItem('무서운', 1),
    MoodItem('참을 수 없는', 1),
    MoodItem('참담한', 1),
    MoodItem('겁나는', 1),
    MoodItem('답답한', 1),
    MoodItem('긴장되는', 1),
    MoodItem('두려운', 2),
    MoodItem('난처한', 2),
    MoodItem('억울한', 2),
    MoodItem('당황스러운', 2),
    MoodItem('걱정스러운', 2),
    MoodItem('어이없는', 2),
    MoodItem('떨리는', 2),
    MoodItem('멍한', 2),
    MoodItem('초조한', 2),
    MoodItem('궁금한', 3),
    MoodItem('부러운', 3),
    MoodItem('뿌듯한', 3),
    MoodItem('여유로운', 3),
    MoodItem('평온한', 3),
    MoodItem('편안한', 3),
    MoodItem('평화로운', 3),
    MoodItem('감사한', 3),
    MoodItem('그저그런', 3),
    MoodItem('만족스러운', 3),
    MoodItem('산뜻한', 4),
    MoodItem('짜릿한', 4),
    MoodItem('반가운', 4),
    MoodItem('기쁜', 4),
    MoodItem('기대되는', 4),
    MoodItem('재미있는', 4),
    MoodItem('흐뭇한', 4),
    MoodItem('감동한', 4),
    MoodItem('희망찬', 5),
    MoodItem('살맛 나는', 5),
    MoodItem('온화한', 5),
    MoodItem('상쾌한', 5),
    MoodItem('괜찮은', 5),
    MoodItem('황홀한', 5),
    MoodItem('끝내주는', 5),
    MoodItem('날아갈 듯한', 5),
    MoodItem('자유로운', 5),
    //추가하는 기능 있어야 함
  ];

  List<String> _selectedMoods = [];

  List<String> get selectedMoods => _selectedMoods;  // getter
  set selectedMoods(List<String> value) {  // setter
    _selectedMoods = value;
    notifyListeners();
  }

  int moodColor = 0;

  void selectMood(String mood) {
    if (selectedMoods.contains(mood)) {
      selectedMoods.remove(mood);
    } else {
      selectedMoods.add(mood);
    }
    notifyListeners();
  }
}

class MoodItem {
  final String name;
  final int moodValue;

  MoodItem(this.name, this.moodValue);
}