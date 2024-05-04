import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mindlog_app/const/visual.dart';
import 'package:provider/provider.dart';

import '../provider/mindlog_provider.dart';

class mindlogMoodPicker extends StatelessWidget {
  const mindlogMoodPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MindlogProvider>(context);

    List<String> selectedMoods = provider.selectedMoods;
    List<MoodItem> moodItems = provider.moodItems;
    int moodColor = provider.moodColor;
    Image heartImage = provider.heartImage;

    double calculateAverageMoodValue() {
      if (selectedMoods.isEmpty) {
        return 0;
      }

      double totalMoodValue = 0;
      for (String mood in selectedMoods) {
        totalMoodValue += moodItems.firstWhere((item) => item.name == mood).moodValue;
      }

      return totalMoodValue / selectedMoods.length;
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                              provider.selectMood(moodItems[index].name);
                              print('Item ${moodItems[index].name} tapped');
                              print('Item list : $selectedMoods');

                              double averageMood = calculateAverageMoodValue();
                              print('Average Mood Value: $averageMood');
                              if (averageMood == 0) {
                                heartImage = heartEmpty;
                                moodColor = 0;
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
                                    style: const TextStyle(
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