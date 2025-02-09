import 'package:flutter/material.dart';

class CategoryPercentage extends StatelessWidget {
   CategoryPercentage({super.key,required this.color,required this.title});
  Color? color;
  String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 11,
          color: color,
        ),
        Text(" ${title}",
            style: TextStyle(
              fontSize: 15,
              color:color,
            )),
      ],
    );
  }
}
