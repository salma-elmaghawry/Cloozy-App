import 'package:cloozy/Core/common/constant.dart';
import 'package:flutter/material.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/onboarding1.png"),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Text(
          "Support Local Brands",
          style: TextStyle(color: PrimaryColor),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          "Shop from your favorite local brands and\nexplore unique styles crafted just for you.",
          style: TextStyle(color: PrimaryColor),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }
}
