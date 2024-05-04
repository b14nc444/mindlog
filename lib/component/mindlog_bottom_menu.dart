import 'package:flutter/material.dart';
import 'package:mindlog_app/model/mindlog_model.dart';
import 'package:provider/provider.dart';

import '../provider/mindlog_provider.dart';
import '../screen/mindlog_writer_screen.dart';

enum MindlogShareItem { exportToText, exportToFile }
enum MindlogMenuItem { updateItem, deleteItem, }

class mindlogBottomMenu extends StatefulWidget {
  final Mindlog mindlog;

  const mindlogBottomMenu({super.key, required this.mindlog});

  @override
  State<mindlogBottomMenu> createState() => _mindlogBottomMenuState();
}

class _mindlogBottomMenuState extends State<mindlogBottomMenu> {
  MindlogShareItem? selectedShareItem;
  MindlogMenuItem? selectedMenuItem;

  @override
  Widget build(BuildContext context) {

    Mindlog mindlog = widget.mindlog;

    return Container(
      color: Colors.white,
      height: 70,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PopupMenuButton<MindlogShareItem>(
              initialValue: null,
              onSelected: (MindlogShareItem item) {
                setState(() {
                  selectedShareItem = item;
                  // 선택된 MenuItem에 따라 다른 동작 수행
                  switch (selectedShareItem) {
                    case MindlogShareItem.exportToText:
                      print('Exported to Text');
                      //텍스트로 내보내기
                    case MindlogShareItem.exportToFile:
                      print('Exported to Txt File');
                      //파일로 내보내기
                    case null: break;
                  }
                  // SnackBar 표시
                });
              },
              icon: Image.asset('assets/icons/share.png'),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<MindlogShareItem>>[
                const PopupMenuItem(
                  value: MindlogShareItem.exportToText,
                  child: Text('텍스트로 내보내기'),
                ),
                const PopupMenuItem(
                  value: MindlogShareItem.exportToFile,
                  child: Text('TXT 파일로 내보내기'),
                ),
              ],
            ),
            //SizedBox(width: 15,),
            PopupMenuButton<MindlogMenuItem>(
              initialValue: null,
              onSelected: (MindlogMenuItem item) {
                setState(() {
                  selectedMenuItem = item;
                  // 선택된 MenuItem에 따라 다른 동작 수행
                  switch (selectedMenuItem) {
                    case MindlogMenuItem.updateItem:
                      // 감정기록 수정 동작 수행
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => mindlogWriterScreen(
                            selectedDate: DateTime.now(),
                            isUpdate: true,
                            modifyingMindlog: mindlog,
                          ))
                      );
                      print('Mindlog updated');
                      break;
                    case MindlogMenuItem.deleteItem:
                    // 감정기록 삭제 동작 수행
                      context.read<MindlogProvider>().deleteMindlog(
                        id: mindlog.id, date: mindlog.date,
                      );
                      print('Mindlog deleted');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("감정기록이 삭제되었습니다.")),
                      );
                      Navigator.pop(context);
                      break;
                    case null: break;
                  }
                });
              },
              icon: Image.asset('assets/icons/meatball.png'),
              itemBuilder: (BuildContext context) => <PopupMenuEntry<MindlogMenuItem>>[
                const PopupMenuItem(
                  value: MindlogMenuItem.updateItem,
                  child: Text('감정기록 수정'),
                ),
                const PopupMenuItem(
                  value: MindlogMenuItem.deleteItem,
                  child: Text('감정기록 삭제'),
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}
