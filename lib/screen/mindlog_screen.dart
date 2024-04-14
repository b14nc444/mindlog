import 'package:flutter/material.dart';
import 'package:mindlog_app/const/visual.dart';

class mindlogScreen extends StatefulWidget {
  const mindlogScreen({super.key});

  @override
  State<mindlogScreen> createState() => _mindlogScreenState();
}

class _mindlogScreenState extends State<mindlogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: TextButton(
          child: Text('취소',
            style: TextStyle(
              color: TYPOGRAPHY_GRAY,
              fontSize: 16
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Text('완료',
              style: TextStyle(
                  color: PRIMARY_COLOR,
                  fontSize: 16
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Center(
            child: Text('감정기록',
              style: TextStyle(
                color: TYPOGRAPHY_GRAY,
                fontSize: 16
              ),
            )
        ),
      ),
    );
  }
}
