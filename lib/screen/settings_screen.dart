import 'package:flutter/material.dart';
import 'package:mindlog_app/screen/settings_alarm_screen.dart';

import '../const/visual.dart';

class settingsScreen extends StatefulWidget {
  const settingsScreen({super.key});

  @override
  State<settingsScreen> createState() => _settingsScreenState();
}

class _settingsScreenState extends State<settingsScreen> {
  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = TextStyle(
      color: basicBlack,
      fontSize: 17,
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w500,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        leadingWidth: 66,
        leading: TextButton(
          child: arrowBackIcon,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => settingsAlarmScreen())
                );
              },
              child: Text('알림', style: textStyle,),
            ),
            const divisionLine(),
            TextButton(
              onPressed: null,
              child: Text('잠금설정', style: textStyle,),
            ),
            const divisionLine(),
            TextButton(
              onPressed: null,
              child: Text('사용방법 다시 보기', style: textStyle,),
            ),
            SizedBox(height: 140,),
          ],
        ),
      ),
    );
  }
}

class divisionLine extends StatelessWidget {
  const divisionLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        width: 95,
        height: 1,
        color: guideGray,
      ),
    );
  }
}
