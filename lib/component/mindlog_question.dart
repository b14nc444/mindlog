import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../const/visual.dart';

class mindlogQuestion extends StatefulWidget {
  final String question;
  final String direction;

  const mindlogQuestion({super.key, required this.question, required this.direction});

  @override
  State<mindlogQuestion> createState() => _mindlogQuestionState();
}

class _mindlogQuestionState extends State<mindlogQuestion> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        constraints: BoxConstraints(minHeight: 50.0),
        width: double.infinity,
        //height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.question,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //print('toggle arrow is tapped');
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    child: _isExpanded ? toggleArrowUp : toggleArrowDown
                  )
                ],
              ),
            ),
            if (_isExpanded)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 5, 16, 16),
                child: Text(
                  widget.direction,
                  style: TextStyle(
                    color: typographyGray2,
                    fontSize: 13,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
