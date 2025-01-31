import 'package:cloozy/Core/common/constant.dart';
import 'package:flutter/material.dart';

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF5F5F5),
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          const Spacer(),
          Text(
            'Discover New Trends',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: PrimaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          const Text(
            'Stay updated with the latest fashion trends\nand curated collections daily.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Image.asset('assets/images/onboarding1.png', height: 250),
        ],
      ),
    );
  }
}
