import 'package:flutter/material.dart';

class CustomHeadline extends StatelessWidget {
  CustomHeadline({super.key, required this.title, this.fontSize});
  String title;
  double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          title,
          style: TextStyle(
              color: Colors.black,
              fontSize: fontSize,
              fontWeight: FontWeight.w500),
        ));
  }
}
