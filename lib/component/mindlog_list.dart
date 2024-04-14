import 'package:flutter/material.dart';

import '../const/visual.dart';

class mindlogList extends StatelessWidget {
  final String mindlogTitle;
  final String contents;

  const mindlogList({
    super.key, required this.mindlogTitle, required this.contents
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
          ),
          child: SizedBox(
            height: 90,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 0, 22),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(mindlogTitle,
                    style: const TextStyle(
                        color: BASIC_BLACK,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.2
                    ),
                  ),
                  Text(contents,
                    style: const TextStyle(
                        color: typographyGray,
                        fontSize: 12,
                        fontWeight: FontWeight.w500
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
