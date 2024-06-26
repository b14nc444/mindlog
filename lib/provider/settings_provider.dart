import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  SettingsProvider() : super() {}

  bool _isAlarming = false;
  List<DateTime> _mindlogAlarms = [];
  List<DateTime> _medicineAlarms = [];

  bool get isAlarming => _isAlarming;
  List<DateTime> get mindlogAlarms => _mindlogAlarms;
  List<DateTime> get medicineAlarms => _medicineAlarms;

}