import 'package:flutter/material.dart';

import '../const/visual.dart';

class mindlogTextField extends StatefulWidget {
  final String hintText;

  final FormFieldSetter<String> onSavedContent;
  final FormFieldValidator<String> contentValidator;

  const mindlogTextField({super.key,
    required this.hintText,
    required this.onSavedContent,
    required this.contentValidator});

  @override
  State<mindlogTextField> createState() => _mindlogTextFieldState();
}

class _mindlogTextFieldState extends State<mindlogTextField> {

  @override
  Widget build(BuildContext context) {

    TextStyle textStyleContent = const TextStyle(
      color: basicBlack,
      fontSize: 18,
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w500,
      letterSpacing: -0.15,
    );

    TextStyle textStyleHint = const TextStyle(
      color: typographyGray1,
      fontSize: 18,
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w500,
      letterSpacing: -0.15,
      height: 1.4,
    );

    InputDecoration inputDecoration = InputDecoration(
      hintText: widget.hintText,
      hintStyle: textStyleHint,
      border: const OutlineInputBorder(
        borderSide: BorderSide.none, // 테두리 없음
      ),
      contentPadding: const EdgeInsets.all(0),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 6, 0, 0),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Expanded(
            child: Container(
              constraints: const BoxConstraints(minHeight: 140.0),
              child: TextFormField(
                maxLines: null,
                cursorColor: typographyGray3,
                keyboardType: TextInputType.multiline,
                decoration: inputDecoration,
                style: textStyleContent,
                onSaved: widget.onSavedContent,
                validator: widget.contentValidator,
              ),
            ),
          ),
        ]
      ),
    );
  }
}
