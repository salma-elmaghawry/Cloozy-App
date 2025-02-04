import 'package:cloozy/Brand/Core/common/constant.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor, // Set the background color
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 15), // Optional: Add padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        "$text",
        style:const  TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
