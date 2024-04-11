import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindlog_app/component/appbar.dart';
import 'package:mindlog_app/component/calendar.dart';
import 'package:mindlog_app/component/navigator.dart';
import 'package:mindlog_app/const/visual.dart';
import 'package:table_calendar/table_calendar.dart';

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
      appBar: renderAppBarHome(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14)
                      ),
                      child: Calendar()
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: SizedBox(
                      height: 90,
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 90,
                            decoration: const ShapeDecoration(
                              color: secondaryColor3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          const Padding( ///////진료 컴포넌트 따로 빼기
                            padding: EdgeInsets.fromLTRB(14, 12, 0, 12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('진료',
                                  style: TextStyle(
                                    color: basicBlack,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text('9:00 - 9:15',
                                  style: TextStyle(
                                      color: basicBlack,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.15
                                  ),
                                ),
                                Text('김정심 원장님',
                                  style: TextStyle(
                                      color: typographyGray,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.15
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const SizedBox(
                      height: 55,
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
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: const SizedBox(
                      height: 90,
                      child: Padding( ////////////컴포넌트 따로 빼기
                        padding: EdgeInsets.fromLTRB(14, 22, 0, 22),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('오늘 기분 최고!',
                              style: TextStyle(
                                  color: basicBlack,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.2
                              ),
                            ),
                            Text('오늘 오전엔 기분이 안좋았는데...',
                              style: TextStyle(
                                  color: typographyGray,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: renderBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

//calender