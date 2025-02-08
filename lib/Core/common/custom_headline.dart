import 'package:flutter/material.dart';

class CustomHeadline extends StatelessWidget {
  CustomHeadline({super.key, required this.title});
  String title;

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          title,
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        ));
  }
}
