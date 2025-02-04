import 'package:cloozy/Brand/Core/common/constant.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  CustomTextButton({
    super.key,
    required this.title,
    this.fontSize,
    required this.onPressed,
    this.color=grayColor,
  });
  final String title;
  double? fontSize;
  Color ?color;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
