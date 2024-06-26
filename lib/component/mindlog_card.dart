import 'package:flutter/material.dart';

import '../const/visual.dart';
import '../model/mindlog_model.dart';
import '../screen/mindlog_viewer_screen.dart';

class mindlogCard extends StatelessWidget {
  final Mindlog mindlog;

  const mindlogCard({super.key, required this.mindlog,});

  @override
  Widget build(BuildContext context) {

    String title = mindlog.title;
    String contents = (mindlog.emotionRecord.length > 20) ? '${mindlog.emotionRecord.substring(0, 20)}...' : mindlog.emotionRecord;

    return InkWell(
      onTap: (){
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => mindlogViewerScreen(
            mindlog: mindlog,
          ))
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)
            ),
            child: SizedBox(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                          style: const TextStyle(
                              color: basicBlack,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.2
                          ),
                        ),
                        Text(contents,
                          style: const TextStyle(
                              color: typographyGray1,
                              fontSize: 12,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                    arrowRightIcon
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
