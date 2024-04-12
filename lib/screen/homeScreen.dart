import 'package:flutter/material.dart';
import 'package:mindlog_app/component/appbar.dart';
import 'package:mindlog_app/component/appointment_list.dart';
import 'package:mindlog_app/component/calendar.dart';
import 'package:mindlog_app/component/mindlog_list.dart';
import 'package:mindlog_app/component/navigator.dart';
import 'package:mindlog_app/const/visual.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor, // 전체 앱의 배경색 지정
        // 다른 테마 속성들
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
  //

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const renderAppBarHome(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14)
                      ),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Calendar(),
                      )
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 14,
                      ),
                      const appointmentList(
                          appointmentTime: '9:00 - 9:15',
                          hospital: '행복주는정신과의원',
                          doctor: '김정심 원장님'
                      ),
                      // const appointmentList(
                      //     appointmentTime: '9:00 - 9:15',
                      //     doctor: '김정심11 원장님'
                      // ),
                      const SizedBox(
                        height: 4,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: const SizedBox(
                          height: 50,
                          child: Center(
                            child: Text('진료 일정 만들기',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const mindlogList(
                          mindlogTitle: '오늘 기분 최고!',
                          contents: '오늘 오전엔 기분이 안좋았는데...'
                      ),
                    ],
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