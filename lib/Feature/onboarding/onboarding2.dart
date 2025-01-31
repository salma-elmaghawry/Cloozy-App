import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset('assets/images/onboarding2.png', height: 250),
          ),
          const SizedBox(height: 40),
          const Text(
            'Shop Smart,\nStay Trendy',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w800,
              color: Color(0xFF360459),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 25),
          Container(
            height: 4,
            width: 100,
            color: const Color(0xFF360459),
          ),
          const SizedBox(height: 30),
          const Text(
            'Get personalized fashion recommendations\nand the best deals in your area.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
