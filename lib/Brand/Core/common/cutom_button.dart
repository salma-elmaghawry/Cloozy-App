import 'package:cloozy/Brand/Core/common/constant.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading; // Add a flag to check for loading state

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false, // Default to false if not passed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed, // Disable the button when loading
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor, // Set the background color
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 15), // Optional: Add padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: isLoading
          ? const CircularProgressIndicator(
              color: Colors.white, // Set the progress indicator color
            )
          : Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
    );
  }
}
