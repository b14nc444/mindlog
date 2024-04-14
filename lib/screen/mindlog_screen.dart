import 'package:flutter/material.dart';
import 'package:mindlog_app/const/visual.dart';

class mindlogScreen extends StatefulWidget {
  const mindlogScreen({super.key});

  @override
  State<mindlogScreen> createState() => _mindlogScreenState();
}

class _mindlogScreenState extends State<mindlogScreen> {

  TextStyle textStyleHintTitle = const TextStyle(
    color: TYPOGRAPHY_GRAY,
    fontSize: 22,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w600,
    letterSpacing: -0.15,
  );

  TextStyle textStyleContent = const TextStyle(
    color: TYPOGRAPHY_GRAY,
    fontSize: 14,
    fontFamily: 'Pretendard',
    fontWeight: FontWeight.w500,
    letterSpacing: -0.15,
  );

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
          TextButton(
            child: Text('완료',
              style: TextStyle(
                  color: PRIMARY_COLOR,
                  fontSize: 16
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              cursorColor: TYPOGRAPHY_GRAY_3,
              maxLines: 1,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                hintText: '오늘을 요약하는 제목을 적어주세요',
                hintStyle: textStyleHintTitle,
              ),
              style: textStyleContent,
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('1. 감정을 기록합니다.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      dropdownIcon
                    ],
                  ),
                ),
              ),
            ),
            TextFormField(),
            SizedBox(
              height: 100,
            ),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('2. 이벤트를 기록합니다.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      dropdownIcon
                    ],
                  ),
                ),
              ),
            ),
            TextFormField(),
            SizedBox(
              height: 100,
            ),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('3. 질문을 기록합니다.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      dropdownIcon
                    ],
                  ),
                ),
              ),
            ),
            TextFormField(),

          ],
        ),
      ),
    );
  }
}
