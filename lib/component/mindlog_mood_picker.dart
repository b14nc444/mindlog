import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mindlog_app/const/visual.dart';

class mindlogMoodPicker extends StatefulWidget {
  const mindlogMoodPicker({super.key});

  @override
  State<mindlogMoodPicker> createState() => _mindlogMoodPickerState();
}

class _mindlogMoodPickerState extends State<mindlogMoodPicker> {

  List<MoodItem> moodItems = [
    MoodItem('섬뜩한', 1),
    MoodItem('죽을 것 같은', 1),
    MoodItem('조마조마한', 1),
    MoodItem('무서운', 1),
    MoodItem('참을 수 없는', 1),
    MoodItem('참담한', 1),
    MoodItem('겁나는', 1),
    MoodItem('답답한', 1),
    MoodItem('긴장되는', 1),
    MoodItem('두려운', 2),
    MoodItem('난처한', 2),
    MoodItem('억울한', 2),
    MoodItem('당황스러운', 2),
    MoodItem('걱정스러운', 2),
    MoodItem('어이없는', 2),
    MoodItem('떨리는', 2),
    MoodItem('멍한', 2),
    MoodItem('초조한', 2),
    MoodItem('궁금한', 3),
    MoodItem('부러운', 3),
    MoodItem('뿌듯한', 3),
    MoodItem('여유로운', 3),
    MoodItem('평온한', 3),
    MoodItem('편안한', 3),
    MoodItem('평화로운', 3),
    MoodItem('감사한', 3),
    MoodItem('그저그런', 3),
    MoodItem('만족스러운', 3),
    MoodItem('산뜻한', 4),
    MoodItem('짜릿한', 4),
    MoodItem('반가운', 4),
    MoodItem('기쁜', 4),
    MoodItem('기대되는', 4),
    MoodItem('재미있는', 4),
    MoodItem('흐뭇한', 4),
    MoodItem('감동한', 4),
    MoodItem('희망찬', 5),
    MoodItem('살맛 나는', 5),
    MoodItem('온화한', 5),
    MoodItem('상쾌한', 5),
    MoodItem('괜찮은', 5),
    MoodItem('황홀한', 5),
    MoodItem('끝내주는', 5),
    MoodItem('날아갈 듯한', 5),
    MoodItem('자유로운', 5),
    //추가 기능 있어야 함
  ];

  List<String> selectedMoods = [];
  Image heartImage = heartEmpty;
  int moodColor = 0;

  void _selectMood(String mood) {
    if (selectedMoods.contains(mood)) {
      selectedMoods.remove(mood);
    } else {
      selectedMoods.add(mood);
    }
    setState(() {});
  }

  double _calculateAverageMoodValue() {
    if (selectedMoods.isEmpty) {
      return 0;
    }

    double totalMoodValue = 0;
    for (String mood in selectedMoods) {
      totalMoodValue += moodItems.firstWhere((item) => item.name == mood).moodValue;
    }

    return totalMoodValue / selectedMoods.length;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(8, 4, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('0. 오늘의 기분을 골라주세요',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  child: SizedBox(
                    width: 120,
                    child: heartImage
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 130,
                    width: double.infinity,
                    child: MasonryGridView.count(
                      scrollDirection: Axis.horizontal,
                          crossAxisCount: 3,
                          mainAxisSpacing: 10.0, // 주축(세로) 방향의 간격
                          crossAxisSpacing: 10.0, // 교차축(가로) 방향의 간격
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectMood(moodItems[index].name);
                                print('Item ${moodItems[index].name} tapped');
                                print('Item list : ${selectedMoods}');

                                double averageMood = _calculateAverageMoodValue();
                                print('Average Mood Value: $averageMood');
                                if (averageMood == 0) {
                                  heartImage = heartEmpty;
                                } else if (averageMood < 2) {
                                  heartImage = heartRed;
                                  moodColor = 1;
                                } else if (averageMood < 3.5) {
                                  heartImage = heartYellow;
                                  moodColor = 3;
                                } else if (averageMood <= 5) {
                                  heartImage = heartGreen;
                                  moodColor = 5;
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: getColorByMoodValue(moodItems[index].moodValue).withOpacity(
                                  selectedMoods.contains(moodItems[index].name) ? 0.4 : 1.0,
                                ),
                                border: Border.all(
                                    color: selectedMoods.contains(moodItems[index].name) ? getColorByMoodValue(moodItems[index].moodValue) : Colors.white,
                                  width: selectedMoods.contains(moodItems[index].name) ? 1 : 0
                                )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text(
                                    moodItems[index].name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: moodItems.length, // 아이템의 개수
                      ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    // floatingActionButton: FloatingActionButton(
    // onPressed: () {
    // setState(() {
    // selectedMoods.clear(); // 선택된 감정 초기화
    // });
    // },
    // child: Icon(Icons.save),
    // ),
  }

  Color getColorByMoodValue(int moodValue) {
    switch (moodValue) {
      case 1:
        return Color(0xffFF6362);
      case 2:
        return Color(0xffFF9B62);
      case 3:
        return Color(0xffFFD362);
      case 4:
        return Color(0xffBBD34F);
      case 5:
        return Color(0xff76D43C);
      default:
        return Color(0xffFF6362);
    }
  }
}

class MoodItem {
  final String name;
  final int moodValue;

  MoodItem(this.name, this.moodValue);
}

// const enum moodKeyword1 = ['섬뜩한', '무서운', '참담한', '겁나는', '죽을 것 같은', '참을 수 없는', '답답한', '조마조마한', '긴장되는']
// const enum moodKeyword2 = ['두려운', '당황스러운', '떨리는', '난처한', '걱정스러운', '멍한', '억울한', '어이없는', '초조한', ]
// const enum moodKeyword3 = ['궁금한', '여유로운', '평화로운', '부러운', '평온한', '감사한', '그저그런', '뿌듯한', '편안한', '만족스러운']
// const enum moodKeyword4 = ['산뜻한', '짜릿한', '기대되는', '반가운', '재미있는', '기쁜', '흐뭇한', '감동한', ]
// const enum moodKeyword5 = ['희망찬', '상쾌한', '끝내주는', '살맛 나는', '괜찮은', '날아갈 듯한', '온화한', '황홀한', '자유로운']

