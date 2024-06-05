import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:mindlog_app/provider/mindlog_provider.dart';
import 'package:mindlog_app/provider/record_provider.dart';
import 'package:mindlog_app/provider/stats_provider.dart';
import 'package:mindlog_app/screen/home_screen.dart';
import 'package:mindlog_app/service/db_server_appointment.dart';
import 'package:mindlog_app/service/db_server_mindlog.dart';
import 'package:mindlog_app/service/db_server_record.dart';
import 'package:mindlog_app/service/db_server_stats.dart';
import 'package:provider/provider.dart';

import 'const/visual.dart';
import 'provider/schedule_provider.dart';

void main() {
  initializeDateFormatting('ko_KR');

  final appointmentRepository = AppointmentRepository();
  final mindlogRepository = MindlogRepository();
  final recordRepository = RecordRepository();
  final statsRepository = StatsRepository();

  final scheduleProvider = ScheduleProvider(repository: appointmentRepository);
  final mindlogProvider = MindlogProvider(repository: mindlogRepository);
  final recordProvider = RecordProvider(repository: recordRepository);
  final statsProvider = StatsProvider(repository: statsRepository);

  runApp(
    MultiProvider( // MultiProvider를 사용하여 여러 Provider를 한번에 추가합니다.
      providers: [
        ChangeNotifierProvider(create: (_) => scheduleProvider),
        ChangeNotifierProvider(create: (_) => mindlogProvider),
        ChangeNotifierProvider(create: (_) => recordProvider),
        ChangeNotifierProvider(create: (_) => statsProvider),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundColor,
          fontFamily: 'pretendard',
        ),
        home: Home(),
      ),
    ),
  );
}


