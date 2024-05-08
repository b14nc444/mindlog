import 'package:flutter/material.dart';

import '../const/visual.dart';

class mindlogTextViewer extends StatelessWidget {

  final String content;

  const mindlogTextViewer({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    TextStyle textStyleContent = const TextStyle(
      color: basicBlack,
      fontSize: 16,
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w500,
      letterSpacing: -0.15,
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 6, 4, 0),
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(minHeight: 140.0),
            child: Text(content,
              style: textStyleContent,)
          ),
        ),
      ),
    );
  }
}
