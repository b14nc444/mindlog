import 'package:flutter/material.dart';

import '../const/visual.dart';

class mindlogQuestion extends StatelessWidget {
  final String question;

  const mindlogQuestion({super.key, required this.question});

  @override
  Widget build(BuildContext context) {

    String _question = question;

    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_question,
                style: const TextStyle(
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
    );
  }
}
