import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/common/headline_text_style.dart';
import 'package:flutter/material.dart';

class LineWithAction extends StatelessWidget {
  String title;
  String actionName;
  void Function()? onTap;

  LineWithAction({
    required this.actionName,
    required this.onTap,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        customText(
          title: title,
          color: Colors.black,
        ),
        GestureDetector(
          onTap: onTap,
          child: customText(
            title: actionName,
            color: primaryColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
