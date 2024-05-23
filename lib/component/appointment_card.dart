import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const/visual.dart';
import '../model/appoinment_model.dart';
import '../provider/schedule_provider.dart';
import '../screen/appointment_screen.dart';
import 'appointment_bottom_sheet.dart';

enum AppointmentMenuItem { updateItem, deleteItem, }
AppointmentMenuItem? selectedMenuItem;

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const AppointmentCard({super.key, required this.appointment,});

  @override
  Widget build(BuildContext context) {

    final scheduleProvider = context.watch<ScheduleProvider>();
    final selectedDay = scheduleProvider.selectedDate;

    return Column(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => appointmentScreen(
                appointment: appointment,)
              ),
            );
          },
          onLongPress: (){
            showModalBottomSheet(
                context: context,
                barrierColor: Colors.black.withAlpha(0),
                builder: (_) => AppointmentBottomSheet(
                  isUpdate: true,
                  modifyingAppointment: appointment,
                ),
                isScrollControlled: true
            );
          },
          child: Container(
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 12, 0, 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('진료',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text('${appointment.startTime} - ${appointment.endTime}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.15
                          ),
                        ),
                        const SizedBox(
                          height: 1,
                        ),
                        Text(
                          (appointment.doctorName != null) ? '${appointment.hospital}  /  ${appointment.doctorName}' : '${appointment.hospital}',
                          style: const TextStyle(
                              color: basicGray,
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
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
//
// void showPopupMenu(BuildContext context, Offset position) async {
//   final RenderBox overlay = Overlay.of(context)!.context
//       .findRenderObject() as RenderBox;
//   final RelativeRect positionPopup = RelativeRect.fromRect(
//     Rect.fromPoints(position, position), // 위치 설정
//     Offset.zero & overlay.size,
//   );
//
//   final AppointmentMenuItem? selectedItem = await showMenu(
//     context: context,
//     position: positionPopup,
//     items: <PopupMenuEntry<AppointmentMenuItem>>[
//       const PopupMenuItem(
//         value: AppointmentMenuItem.updateItem,
//         child: Text('일정 수정'),
//       ),
//       const PopupMenuItem(
//         value: AppointmentMenuItem.deleteItem,
//         child: Text('일정 삭제'),
//       ),
//     ],
//   );
//
//   if (selectedItem != null) {
//     // 팝업 메뉴 항목을 처리하는 코드 작성
//     // selectedItem에 따라 다른 작업을 수행할 수 있습니다.
//     switch (selectedItem) {
//       case AppointmentMenuItem.updateItem:
//       // Update 항목을 선택한 경우 처리
//         showModalBottomSheet(
//             context: context,
//             barrierColor: Colors.black.withAlpha(0),
//             builder: (_) => AppointmentBottomSheet(),
//             isScrollControlled: true
//         );
//         break;
//       case AppointmentMenuItem.deleteItem:
//       // Delete 항목을 선택한 경우 처리
//         deleteAppointment(context, 1,);
//         print('Mindlog deleted');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("감정기록이 삭제되었습니다.")),
//         );
//         Navigator.pop(context);
//         break;
//     }
//   }
// }


// setState(() {
// selectedMenuItem = item;
// // 선택된 MenuItem에 따라 다른 동작 수행
// switch (selectedMenuItem) {
// case MindlogMenuItem.updateItem:
// // 감정기록 수정 동작 수행
// updateMindlog(context, 1, Mindlog(
// date: '',
// mood: '',
// moodColor: '',
// title: '',
// emotionRecord: '',
// eventRecord: '',
// questionRecord: ''
// ));
// print('Mindlog updated');
// break;
// case MindlogMenuItem.deleteItem:
// // 감정기록 삭제 동작 수행
// deleteMindlog(context, 1,);
// print('Mindlog deleted');
// ScaffoldMessenger.of(context).showSnackBar(
// SnackBar(content: Text("감정기록이 삭제되었습니다.")),
// );
// Navigator.pop(context);
// break;
// case null: break;
// }
// });