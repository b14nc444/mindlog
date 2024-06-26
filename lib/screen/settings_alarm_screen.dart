import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindlog_app/component/setting_bottom_sheet.dart';
import 'package:mindlog_app/provider/settings_provider.dart';
import 'package:provider/provider.dart';

import '../const/visual.dart';
import '../provider/settings_provider.dart';

class settingsAlarmScreen extends StatefulWidget {
  const settingsAlarmScreen({super.key});

  @override
  State<settingsAlarmScreen> createState() => _settingsAlarmScreenState();
}

class _settingsAlarmScreenState extends State<settingsAlarmScreen> {

  bool _setForPush = true;
  bool _setForMindlog = true;
  bool _setForMedicine = false;
  bool _setTest = false;

  //TimeOfDay _mindlogTime = parseTimeOfDay('10:00 PM');
  List<TimeOfDay> _medicineTimes = [];

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = TextStyle(
      color: basicBlack,
      fontSize: 16,
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w600,
    );

    TextStyle textStyle2 = TextStyle(
      color: basicBlack,
      fontSize: 16,
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w500,
    );

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          scrolledUnderElevation: 0,
          leadingWidth: 150,
          leading: IconButton(
            icon: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 10,),
                arrowBackIcon,
                SizedBox(width: 10,),
                Text('설정', style: TextStyle(
                    color: basicGray,
                    fontSize: 16
                ),),
              ],
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('푸시 알림', style: textStyle,),
                    Switch(
                      activeColor: Colors.white,
                      activeTrackColor: primaryColor,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: guideGray,
                      value: _setForPush,
                      onChanged: (value) {
                        setState(() {
                          _setForPush = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 12,
                color: guideGray,
              ),
              if(_setForPush == true)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.horizontal_rule, color: basicGray,),
                              Text('  감정 기록 알림', style: textStyle2,),
                            ],
                          ),
                          Switch(
                            activeColor: Colors.white,
                            activeTrackColor: primaryColor,
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: guideGray,
                            value: _setForMindlog,
                            onChanged: (value) {
                              setState(() {
                                _setForMindlog = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          barrierColor: Colors.black.withAlpha(0),
                          builder: (_) => settingBottomSheet(
                            type: 0,
                            onTimeSelected: (time) {
                              // 선택한 시간 값을 state에 저장하고, UI 업데이트
                              setState(() {
                                //_mindlogTime = time;
                              });
                            },
                          ),
                        );
                      },
                      child: Container(
                        height: 40,
                        padding: const EdgeInsets.all(10),
                        decoration: ShapeDecoration(
                          color: secondaryColor2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          // DateFormat.jm().format(DateTime(_mindlogTime.hour, _mindlogTime.minute)),
                          '10:00 PM',
                          style: TextStyle(
                            color: primaryColor,
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    //구분선
                    Padding(
                      padding: const EdgeInsets.only(top: 24, bottom: 6),
                      child: Container(
                        width: double.infinity,
                        height: 1,
                        color: guideGray,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.horizontal_rule, color: basicGray,),
                              Text('  약 복용 알림', style: textStyle2,),
                            ],
                          ),
                          Switch(
                            activeColor: Colors.white,
                            activeTrackColor: primaryColor,
                            inactiveThumbColor: Colors.white,
                            inactiveTrackColor: guideGray,
                            value: _setForMedicine,
                            onChanged: (value) {
                              setState(() {
                                _setForMedicine = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    if (_setForMedicine)
                      Column(
                        children: [
                          MedicineCard(time: '9:41 AM', memo: '정신과 아침 약',),
                          if(_setTest == true)
                            MedicineCard(time: '10:00 PM', memo: '정신과 저녁 약',),
                          TextButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  barrierColor: Colors.black.withAlpha(0),
                                  builder: (_) => settingBottomSheet(
                                    type: 1,
                                    onTimeSelected: (time) {
                                      // 선택한 시간 값을 state에 저장하고, UI 업데이트
                                      setState(() {
                                        _medicineTimes[_medicineTimes.length] = time;
                                      });
                                    },
                                  ),
                              );
                              setState(() {
                                _setTest = true;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add, color: basicGray,),
                                  Text(' 알림 추가하기', style: TextStyle(
                                    color: basicGray
                                  ),),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                  ],
                ),
            ],
          ),
        ),
    );
  }
}

class MedicineCard extends StatefulWidget {
  final String time;
  final String memo;

  const MedicineCard({super.key, required this.time, required this.memo});

  @override
  State<MedicineCard> createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 24, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.time,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4,),
                  Row(
                    children: [
                      SizedBox(
                        width: 12,
                        child: Image.asset('assets/icons/medicine_icon.png')
                      ),
                      Text(' ${widget.memo}'),
                    ],
                  ),
                ],
              ),
              Switch(
                  value: false,
                  onChanged: null
              )
            ],
          ),
        ),
      ),
    );
  }
}
