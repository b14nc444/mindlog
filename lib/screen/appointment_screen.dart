import 'package:flutter/material.dart';
import 'package:mindlog_app/component/appbar.dart';

class appointmentScreen extends StatefulWidget {
  const appointmentScreen({super.key});

  @override
  State<appointmentScreen> createState() => _appointmentScreenState();
}

class _appointmentScreenState extends State<appointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Center(
            child: Text('진료')
        ),
      ),
    );
  }
}
