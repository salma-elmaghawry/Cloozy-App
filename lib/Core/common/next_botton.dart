import 'package:cloozy/Core/common/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg package

class ButtonWithIcon extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final String assetpath;

  const ButtonWithIcon({
    Key? key,
    required this.text,
    required this.onPressed, required this.assetpath,
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
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(width: 8), // Space between text and icon
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                assetpath,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
