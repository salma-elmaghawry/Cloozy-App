import 'package:cloozy/Core/common/constant.dart';
import 'package:flutter/material.dart';

class customText extends StatelessWidget {
  customText(
      {super.key,
      required this.title,
      this.color,
      this.fontSize,
      this.fontWeight = FontWeight.w500,this.fontFamily});

  final String title;
  Color? color;
  double? fontSize;
  FontWeight? fontWeight;
  String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
          fontFamily: fontFamily),
    );
  }
}
