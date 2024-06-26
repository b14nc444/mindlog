import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindlog_app/provider/schedule_provider.dart';
import 'package:mindlog_app/provider/stats_provider.dart';
import 'package:provider/provider.dart';

import '../const/visual.dart';
import '../model/mindlog_model.dart';
import '../provider/mindlog_provider.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({super.key});

  @override
  State<StatisticScreen> createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    context.read<MindlogProvider>().getMindlogsAll();
    context.read<ScheduleProvider>().getAppointmentsAll();
    context.read<StatsProvider>().getNegativeSituation();
    context.read<StatsProvider>().getPositiveSituation();
    context.read<StatsProvider>().getKeyword();
  }

  @override
  Widget build(BuildContext context) {
    final mindlogProvider = context.watch<MindlogProvider>();
    final scheduleProvider = context.watch<ScheduleProvider>();
    final statsProvider = context.watch<StatsProvider>();

    final allMindlogs = mindlogProvider.allMindlogs;
    final allAppointments = scheduleProvider.allAppointments;
    final negativeSituations = statsProvider.negativeSituations;
    final positiveSituations = statsProvider.positiveSituations;
    final keywords = statsProvider.keywords;

    final moodColorPercentage1 = CalculateMoodColorRate(allMindlogs, 1);
    final moodColorPercentage2 = CalculateMoodColorRate(allMindlogs, 2);
    final moodColorPercentage3 = CalculateMoodColorRate(allMindlogs, 3);
    final moodColorPercentage4 = CalculateMoodColorRate(allMindlogs, 4);
    final moodColorPercentage5 = CalculateMoodColorRate(allMindlogs, 5);

    TextStyle textStyleTitle = TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w600,
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          //상단바
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.chevron_left_rounded, color: basicGray,),
                Text('2024년 5월', style: TextStyle(
                  color: basicBlack,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),),
                Icon(Icons.chevron_right_rounded, color: basicGray),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 2,
            color: guideGray,
          ),
          //본문
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Text(keywords.length.toString()),
                //개수 세기
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.chat_bubble_rounded, color: primaryColor, size: 18,),
                                // Image.asset('assets/icons/chat_bubble.png'),
                                SizedBox(width: 5,),
                                Text('${allMindlogs.length}개', style: textStyleTitle,),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Text('기록한 감정', style: TextStyle(
                              color: Color(0xFFABABAB),
                              fontSize: 13,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                            ),),
                          ],
                        ),
                        Container(
                          width: 1,
                          height: 65,
                          color: guideGray,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                // Icon(Icons.pl, color: primaryColor, size: 18,),
                                Image.asset('assets/icons/hospital_cross.png'),
                                SizedBox(width: 5,),
                                Text('${allAppointments.length}개', style: textStyleTitle),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Text('기록한 진료', style: TextStyle(
                              color: Color(0xFFABABAB),
                              fontSize: 13,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                            ),),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('감정 통계', style: textStyleTitle,),
                        SizedBox(height: 14,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 132,
                              height: 132,
                              child: PieChart(
                                PieChartData(
                                  sections: [
                                    PieChartSectionData(value: moodColorPercentage1, color: getColorByMoodValue(1), radius: 30, showTitle: false),
                                    PieChartSectionData(value: moodColorPercentage2, color: getColorByMoodValue(2), radius: 30, showTitle: false),
                                    PieChartSectionData(value: moodColorPercentage3, color: getColorByMoodValue(3), radius: 30, showTitle: false),
                                    PieChartSectionData(value: moodColorPercentage4, color: getColorByMoodValue(4), radius: 30, showTitle: false),
                                    PieChartSectionData(value: moodColorPercentage5, color: getColorByMoodValue(5), radius: 30, showTitle: false),
                                  ],
                                  sectionsSpace: 0,
                                ),
                                // swapAnimationDuration: Duration(milliseconds: 150), // Optional
                                // swapAnimationCurve: Curves.linear, // Optional
                              ),
                            ),
                            SizedBox(
                              height: 132,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RenderLegend(moodColor: 1, percent:moodColorPercentage1),
                                  RenderLegend(moodColor: 2, percent: moodColorPercentage2),
                                  RenderLegend(moodColor: 3, percent: moodColorPercentage3),
                                  RenderLegend(moodColor: 4, percent: moodColorPercentage4),
                                  RenderLegend(moodColor: 5, percent: moodColorPercentage5),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                EventRanking(
                  title: '👎 이럴 때 기분이 나빴어요',
                  events: negativeSituations.isEmpty
                      ? ['집계 불가'] : negativeSituations.length == 1
                      ? [negativeSituations[0]] : negativeSituations.length == 2
                      ? negativeSituations.sublist(0, 2) : negativeSituations.sublist(0, 3),
                ),
                SizedBox(height: 20,),
                EventRanking(
                  title: '👍 이럴 때 기분이 좋았어요',
                  events: positiveSituations.isEmpty
                      ? ['집계 불가'] : positiveSituations.length == 1
                      ? [positiveSituations[0]] : positiveSituations.length == 2
                      ? positiveSituations.sublist(0, 2) : positiveSituations.sublist(0, 3),
                ),
                SizedBox(height: 20,),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('가장 많이 언급한 단어 - 감정', style: textStyleTitle,),
                        SizedBox(height: 14,),
                        if (keywords.isNotEmpty) ...[
                          KeywordRanking(rank: '1', keyword: keywords.length > 0 ? keywords[0] : '집계 불가', mood: '#뿌듯한', moodColor: 3,),
                          SizedBox(height: 14,),
                          KeywordRanking(rank: '2', keyword: keywords.length > 0 ? keywords[1] : '집계 불가', mood: '#걱정스러운', moodColor: 2,),
                          SizedBox(height: 14,),
                          KeywordRanking(rank: '3', keyword: keywords.length > 1 ? keywords[2] : '집계 불가', mood: '#답답한', moodColor: 1,),
                        ],
                      ],
                    ),
                  ),
                ),
              ]
            ),
          ),
        ],
      ),
    );
  }
}

CalculateMoodColorRate(List<Mindlog> mindlogs, int moodColor) {
  if (mindlogs.isEmpty) {
    return 0.0;
  }

  int totalCount = mindlogs.length;
  int count = 0;

  for (var mindlog in mindlogs) {
    if (mindlog.moodColor == moodColor)
      count += 1;
  }

  double percentage = (count / totalCount) * 100;
  return percentage;
}

class RenderLegend extends StatelessWidget {
  final int moodColor;
  final double percent;

  const RenderLegend({super.key, required this.moodColor, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: ShapeDecoration(
            color: getColorByMoodValue(moodColor),
            shape: OvalBorder(),
          ),
        ),
        SizedBox(width: 8,),
        Text('${percent.round()}%')
      ],
    );
  }
}


class EventRanking extends StatelessWidget {
  final String title;
  final List<String> events;

  const EventRanking({super.key, required this.title, required this.events});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
            child: Text(title, style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),),
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: guideGray,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: events
                  .asMap()
                  .entries
                  .map((entry) => Padding(
                padding: EdgeInsets.only(
                    bottom: entry.key == events.length - 1 ? 0.0 : 15.0),
                child: BulletText(bullet: '•', text: entry.value),
              ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class KeywordRanking extends StatelessWidget {
  final String rank;
  final String keyword;
  final String mood;
  final int moodColor;

  const KeywordRanking({super.key, required this.rank, required this.keyword, required this.mood, required this.moodColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 43,
          height: 43,
          decoration: ShapeDecoration(
            color: secondaryColor1,
            shape: OvalBorder(),
          ),
          child: Center(
            child: Text(
              rank, style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColor
            ),),
          ),
        ),
        SizedBox(width: 12,),
        Text(keyword),
        SizedBox(width: 18,),
        Expanded(
          child: Container(
            height: 0.7,
            color: secondaryColor3,
          ),
        ),
        SizedBox(width: 18,),
        Container(
          height: 28,
          decoration: BoxDecoration(
            color: getColorByMoodValue(moodColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
              child: Text(mood, style: TextStyle(
                  fontSize: 12,
                  color: Colors.white
              ),),
            ),
          ),
        )
      ],
    );
  }
}

getColorByMoodValue(int value) {
  switch (value) {
    case 1:
      return const Color(0xffFF6362);
    case 2:
      return const Color(0xffFF9B62);
    case 3:
      return const Color(0xffFFD362);
    case 4:
      return const Color(0xffBBD34F);
    case 5:
      return const Color(0xff76D43C);
    default:
      return const Color(0xffFF6362);
  }
}

class BulletText extends StatelessWidget {
  final String bullet;
  final String text;

  BulletText({required this.bullet, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          bullet,
          style: TextStyle(fontSize: 16), // 글머리표 스타일
        ),
        SizedBox(width: 5), // 글머리표와 텍스트 사이의 간격
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 16), // 텍스트 스타일
          ),
        ),
      ],
    );
  }
}