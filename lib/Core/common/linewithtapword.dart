import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/common/headline_text_style.dart';
import 'package:cloozy/Feature/Auth/presentation/views/register/registerpage1.dart';
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
            color: PrimaryColor,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
