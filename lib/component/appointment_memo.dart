import 'package:flutter/material.dart';
import 'package:mindlog_app/provider/schedule_provider.dart';
import 'package:provider/provider.dart';

import '../const/visual.dart';
import '../model/appoinment_model.dart';

class appointmentMemo extends StatefulWidget {
  final Appointment appointment;

  const appointmentMemo({super.key, required this.appointment});

  @override
  State<appointmentMemo> createState() => _appointmentMemoState();
}

class _appointmentMemoState extends State<appointmentMemo> {

  late TextEditingController _textEditingController;
  String? memo;

  // @override
  // void initState() {
  //   super.initState();
  //   _textEditingController = TextEditingController();
  //   memo = widget.appointment.memo ?? ''; // 기존 메모 또는 빈 문자열 할당
  //   _textEditingController.text = memo!; // 텍스트 필드에 기존 메모 표시
  // }

  @override
  Widget build(BuildContext context) {
    Appointment appointment = widget.appointment;

    final provider = context.watch<ScheduleProvider>();
    // provider.updateAppointmentMemo(id: appointment.id!, memo: memo!);
    
    return Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints(minHeight: 80.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    initialValue: appointment.memo,
                    maxLines: null,
                    cursorColor: typographyGray3,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      hintText: '진료 중 메모하고 싶은 것을 여기에 적어주세요',
                      hintStyle: TextStyle(
                        color: typographyGray1,
                        letterSpacing: -0.15,
                        height: 1.4,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none, // 테두리 없음
                      ),
                      contentPadding: EdgeInsets.all(0),
                    ),
                    style: const TextStyle(
                      color: basicBlack,
                      letterSpacing: -0.15,
                    ),
                    onChanged: (String? val) {
                      setState(() {
                        memo = val;
                      });
                      // memo가 변경될 때마다 업데이트
                      provider.updateAppointmentMemo(id: appointment.id!, memo: memo!);
                      print('memo updated : $memo');
                    },
                  ),
              ),
            ),
          )
        ]
    );
  }
}
