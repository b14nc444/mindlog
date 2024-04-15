import 'package:flutter/material.dart';

import '../const/visual.dart';

class mindlogTextField extends StatefulWidget {
  final String hintText;

  const mindlogTextField({super.key, required this.hintText});

  @override
  State<mindlogTextField> createState() => _mindlogTextFieldState();
}

class _mindlogTextFieldState extends State<mindlogTextField> {

  @override
  Widget build(BuildContext context) {;

    TextStyle textStyleContent = const TextStyle(
      color: BASIC_BLACK,
      fontSize: 18,
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w500,
      letterSpacing: -0.15,
    );

    TextStyle textStyleHint = const TextStyle(
      color: TYPOGRAPHY_GRAY,
      fontSize: 18,
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w500,
      letterSpacing: -0.15,
      height: 1.4,
    );

    InputDecoration inputDecoration = InputDecoration(
      hintText: widget.hintText,
      hintStyle: textStyleHint,
      border: OutlineInputBorder(
        borderSide: BorderSide.none, // 테두리 없음
      ),
      contentPadding: EdgeInsets.all(0),
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(10, 6, 0, 0),
      child: Expanded(
        child: Container(
          constraints: BoxConstraints(minHeight: 140.0),
          child: TextFormField(
            maxLines: null,
            cursorColor: TYPOGRAPHY_GRAY_3,
            keyboardType: TextInputType.multiline,
            decoration: inputDecoration,
            style: textStyleContent,
          ),
        ),
      ),
    );
  }
}
