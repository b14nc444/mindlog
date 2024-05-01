import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:mindlog_app/component/appbar.dart';
import 'package:mindlog_app/component/appointment_bottom_sheet.dart';
import 'package:mindlog_app/component/appointment_card.dart';
import 'package:mindlog_app/component/calendar.dart';
import 'package:mindlog_app/component/mindlog_card.dart';
import 'package:mindlog_app/component/navigation.dart';
import 'package:mindlog_app/const/visual.dart';
import 'package:mindlog_app/model/mindlog_model.dart';
import 'package:mindlog_app/screen/appointment_screen.dart';
import 'package:mindlog_app/screen/mindlog_viewer_screen.dart';
import 'package:mindlog_app/screen/mindlog_writer_screen.dart';
import 'package:mindlog_app/service/db_server_appointment.dart';

import '../model/appoinment_model.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        fontFamily: 'pretendard',
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //navigation
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //swipe down
  double _objectPositionY = 0;
  double _startY = 0;
  double _endY = 0;

  //get date
  DateTime? _selectedDate;


  // Calendar calendarWidget = Calendar();
  // DateTime? selectedDay = calendarWidget.selectedDay;

  @override
  Widget build(BuildContext context) {

    initializeDateFormatting('ko_KR');

    return Scaffold(
      appBar: const RenderAppBarHome(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14)
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Calendar(
                          onDaySelected: (selectedDay) {
                            setState(() {
                              _selectedDate = selectedDay;
                            });
                          },
                        ),
                      )
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  const AppointmentCard(
                      startTime: '16:30',
                      endTime: '17:00',
                      hospital: '고려숲정신건강의학과의원',
                      doctor: '형원석 원장님'
                  ),
                  // InkWell(
                  //   onTap: (){
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(builder: (context) => appointmentScreen()),
                  //     );
                  //   },
                  //   child: const AppointmentCard(
                  //       startTime: '17:00',
                  //       endTime: '17:30',
                  //       hospital: '고려숲정신건강의학과의원',
                  //       doctor: '형원석 원장님'
                  //   ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: 50,
                    child: FilledButton(
                      onPressed: () {
                        // getAppointmentById(context, 1);
                        // deleteAppointment(context, 1);
                        showModalBottomSheet(
                          context: context,
                          barrierColor: Colors.black.withAlpha(0),
                          builder: (_) => AppointmentBottomSheet(
                            selectedDate: _selectedDate ?? DateTime.now(),
                            //calendarWidget.selectedDay; // _selectedDay 변수에 접근
                          ),
                          isScrollControlled: true
                          );
                        },
                      style: FilledButton.styleFrom(
                        backgroundColor: primaryColor,
                        textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text('진료 일정 만들기',
                        style: TextStyle(
                          fontFamily: 'pretendard',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.15
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            // deleteMindlog(context, 1);
                            Navigator.push(
                              context, MaterialPageRoute(builder: (context) => mindlogViewerScreen(
                                selectedDate: DateTime.now(),
                              ))
                            );
                          },
                          child: StreamBuilder<List<Mindlog>>(
                            stream: null,
                            //getAppointmentByDate(context, DateFormat('yyyy-MM-dd(E)', 'ko_KR').format(_selectedDate ?? DateTime.now())),
                            builder: (context, snapshot) {
                              if(!snapshot.hasData) {
                                return Container();
                              }
                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final mindlog = snapshot.data![index];
                                  return mindlogCard(
                                      mindlogTitle: mindlog.title ?? 'title',
                                      //'오늘 기분 최고!',
                                      contents: '오늘 오전엔 기분이 안좋았는데...'
                                  );
                                },
                              );
                            }
                          ),
                        ),
                        //testtesttesttesttesttesttest
                        InkWell(
                          onTap: (){
                            // deleteMindlog(context, 1);
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => mindlogViewerScreen(
                              selectedDate: DateTime.now(),
                            ))
                            );
                          },
                          child: mindlogCard(
                              mindlogTitle: '오늘 기분 최고!',
                              contents: '오늘 오전엔 기분이 안좋았는데...'
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            // deleteMindlog(context, 1);
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => mindlogViewerScreen(
                              selectedDate: DateTime.now(),
                            ))
                            );
                          },
                          child: mindlogCard(
                              mindlogTitle: '저희 진짜 열심히 했어요',
                              contents: '피곤하다… 시험 하나만 봐서 별로...'
                          ),
                        ),
                        // mindlogCard(
                        //     mindlogTitle: '드디어 서버 연동 했다!!!!',
                        //     contents: '며칠동안 매달렸는데 겨우 성공해서...'
                        // ),
                        GestureDetector(
                          // onTap: () {
                          //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => mindlogScreen()));
                          //   print('clicked');
                          //   },
                          onVerticalDragStart: (details) {
                            _startY = details.localPosition.dy;
                          },
                          onVerticalDragUpdate: (details) {
                            _endY = details.localPosition.dy;
                            double distance = _endY - _startY;
                            setState(() {
                              _objectPositionY += distance;
                            });
                          },
                          onVerticalDragEnd: (details) {
                            if (details.primaryVelocity! > 0) {
                              Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => mindlogWriterScreen(
                                    selectedDate: DateTime.now(),
                                  ))
                              );
                              print('swiped down');
                              _objectPositionY = -1;
                            }
                          },
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.transparent
                            ),
                            child: Padding(
                              padding: _objectPositionY > 0
                                  ? EdgeInsets.only(top: _objectPositionY / 30)
                                  : const EdgeInsets.only(top: 0),
                              child: const Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Image(image: AssetImage('assets/icons/arrow_down.png')),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text('스와이프하면 감정을 기록할 수 있어요',
                                      style: TextStyle(
                                        color: basicGray,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: -0.13,
                                      )
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: renderBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

//calender