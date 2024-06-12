import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mindlog_app/component/appbar.dart';
import 'package:mindlog_app/component/appointment_bottom_sheet.dart';
import 'package:mindlog_app/component/appointment_card.dart';
import 'package:mindlog_app/component/calendar.dart';
import 'package:mindlog_app/component/mindlog_card.dart';
import 'package:mindlog_app/component/navigation.dart';
import 'package:mindlog_app/const/visual.dart';
import 'package:mindlog_app/model/appoinment_model.dart';
import 'package:mindlog_app/model/mindlog_model.dart';
import 'package:mindlog_app/provider/mindlog_provider.dart';
import 'package:mindlog_app/provider/schedule_provider.dart';
import 'package:mindlog_app/screen/mindlog_writer_screen.dart';
import 'package:mindlog_app/screen/statistic_screen.dart';
import 'package:mindlog_app/screen/timeline_screen.dart';
import 'package:provider/provider.dart';

import 'appointment_screen.dart';
import 'mindlog_viewer_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RenderAppBarHome(index: _selectedIndex),
      body: _buildBody(_selectedIndex),
      bottomNavigationBar: renderBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const TimelineScreen();
      case 2:
        return const StatisticScreen();
      default:
        return Container();
    }
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    super.initState();
    final scheduleProvider = context.read<ScheduleProvider>();
    final mindlogProvider = context.read<MindlogProvider>();
    final currentDate = DateTime.now();

    scheduleProvider.getAppointmentsAll();
    mindlogProvider.getMindlogsAll();
    scheduleProvider.getAppointmentByDate(date: currentDate);
    mindlogProvider.getMindlogByDate(date: currentDate);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scheduleProvider.addListener(_refreshData);
      mindlogProvider.addListener(_refreshData);
    });
  }

  // @override
  // void dispose() {
  //   final scheduleProvider = context.read<ScheduleProvider>();
  //   final mindlogProvider = context.read<MindlogProvider>();
  //
  //   scheduleProvider.removeListener(_refreshData);
  //   mindlogProvider.removeListener(_refreshData);
  //
  //   super.dispose();
  // }

  void _refreshData() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheduleProvider = context.watch<ScheduleProvider>();
    final mindlogProvider = context.watch<MindlogProvider>();

    final selectedDay = scheduleProvider.formattedDate;
    final appointments = scheduleProvider.cache[selectedDay] ?? [];
    final mindlogs = mindlogProvider.cache[selectedDay] ?? [];

    final allMindlogs = mindlogProvider.allMindlogs;
    final allAppointments = scheduleProvider.allAppointments;

    initializeDateFormatting('ko_KR');

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 260,),
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
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Calendar(),
                        )
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    /////////TEST////////////
                    // Text(appointments.toString()),
                    // Text(selectedDay),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(), // 스크롤 비활성화
                      shrinkWrap: true,
                      itemCount: appointments.length,
                      itemBuilder: (BuildContext context, int index) {
                        final appointment = appointments[index];

                        return Dismissible(
                          key: ObjectKey(appointment.id),
                          direction: DismissDirection.endToStart,
                          onDismissed: (DismissDirection direction) {
                            scheduleProvider.deleteAppointment(
                                id: appointment.id, date: appointment.date
                            );
                          },
                          child: AppointmentCard(appointment: appointment,),
                        );
                      },
                    ),
                    // Text(selectedDay), /////////TEST//////
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
                            builder: (_) => const AppointmentBottomSheet(isUpdate: false,),
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
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(), // 스크롤 비활성화
                      shrinkWrap: true,
                      itemCount: mindlogs.length,
                      itemBuilder: (BuildContext context, int index) {
                        final mindlog = mindlogs[index];

                        return mindlogCard(mindlog: mindlog,);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        HomeContainer(allMindlogs: allMindlogs, allAppointments: allAppointments,),
      ],
    );
  }
}

class HomeContainer extends StatefulWidget {
  final allMindlogs;
  final allAppointments;

  const HomeContainer({super.key, this.allMindlogs, this.allAppointments});

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  @override
  Widget build(BuildContext context) {

    //swipe down
    double _objectPositionY = 0;
    double _startY = 0;
    double _endY = 0;

    TextStyle textStyleTitle = const TextStyle(
      color: secondaryColor3,
      fontSize: 21,
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w700,
    );

    TextStyle textStyleTitle2 = const TextStyle(
      color: primaryColor,
      fontSize: 21,
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w700,
    );

    TextStyle textStyle = const TextStyle(
      color: secondaryColor3,
      fontSize: 12,
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w500,
    );

    TextStyle textStyle2 = const TextStyle(
      color: secondaryColor3,
      fontSize: 15,
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w600,
    );

    return Stack(
      children: [
        //박스(상호작용)
        GestureDetector(
          onVerticalDragStart: (details) {
            _startY = details.localPosition.dy;
          },
          onVerticalDragUpdate: (details) {
            double distance = details.globalPosition.dy - _startY;
            if (mounted) {
              setState(() {
                _objectPositionY = distance;
              });
            }
          },
          onVerticalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => mindlogWriterScreen(
                    isUpdate: false,
                  ))
              );
              print('swiped down');
              _objectPositionY = 0;
            } else {
              setState(() {
                _objectPositionY = 0;
              });
            }
          },
          child: Container(
            margin: _objectPositionY > 0
                ? EdgeInsets.only(top: _objectPositionY / 30)
                : const EdgeInsets.only(top: 0),
            width: double.infinity,
            height: 250,
            decoration: const BoxDecoration(
              color: secondaryColor1,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x19000000),
                  blurRadius: 19.70,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: const Column(
              children: [
                SizedBox(
                  height: 164,
                ),
                Image(image: AssetImage('assets/icons/arrow_down.png')),
                SizedBox(height: 12,),
                Text('스와이프하면 감정을 기록할 수 있어요',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.13,
                    )
                )
              ],
            ),
          ),
        ),
        //내용
        Positioned(
          left: 20,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 22,),
                  Row(
                    children: [
                      Text('오늘의 ', style: textStyleTitle,),
                      Text('마인드로그', style: textStyleTitle2,),
                      Text('를', style: textStyleTitle,),
                    ],
                  ),
                  Text('남겨볼까요?', style: textStyleTitle,),
                  const SizedBox(height: 18,),
                  Row(
                    children: [
                      Text('기록한 감정  ', style: textStyle,),
                      Image.asset('assets/icons/chat_bubble.png'),
                      SizedBox(width: 5,),
                      Text('${widget.allMindlogs.length}개', style: textStyle2,),
                    ],
                  ),
                  const SizedBox(height: 6,),
                  Row(
                    children: [
                      Text('기록한 진료  ', style: textStyle,),
                      Image.asset('assets/icons/hospital_cross.png'),
                      const SizedBox(width: 5,),
                      Text('${widget.allAppointments.length}개', style: textStyle2,),
                    ],
                  ),
                ],
              ),
              SizedBox(width: 6,),
              SizedBox(
                  width: 180,
                  child: Image.asset('assets/icons/home_illust.png')
              ),
            ],
          ),
        ),
      ],
    );
  }
}
