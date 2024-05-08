import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:mindlog_app/provider/mindlog_provider.dart';
import 'package:mindlog_app/screen/home_screen.dart';
import 'package:mindlog_app/service/db_server_appointment.dart';
import 'package:mindlog_app/service/db_server_mindlog.dart';
import 'package:provider/provider.dart';

import 'const/visual.dart';
import 'provider/schedule_provider.dart';

void main() {
  initializeDateFormatting('ko_KR');

  final appointmentRepository = AppointmentRepository();
  final mindlogRepository = MindlogRepository();
  final scheduleProvider = ScheduleProvider(repository: appointmentRepository);
  final mindlogProvider = MindlogProvider(repository: mindlogRepository);

  runApp(
    MultiProvider( // MultiProvider를 사용하여 여러 Provider를 한번에 추가합니다.
      providers: [
        ChangeNotifierProvider(create: (_) => scheduleProvider),
        ChangeNotifierProvider(create: (_) => mindlogProvider),
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


