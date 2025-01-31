import 'package:flutter/material.dart';

class SymmetricalCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.8); // Start at 80% height on the left

    // Symmetrical curve peaking in the center
    path.quadraticBezierTo(
        size.width / 2,
        size.height * 1.0, // Control point at the center
        size.width,
        size.height * 0.9); // End at 80% height on the right

    path.lineTo(size.width, 0); // Close the path at the top-right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class AsymmetricalCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.7); // Start at 70% height on the left

    // Asymmetrical curve peaking more on the right
    path.quadraticBezierTo(
        size.width * 0.7,
        size.height * 1.2, // Control point shifted to the right
        size.width,
        size.height * 0.8); // End at 80% height on the right

    path.lineTo(size.width, 0); // Close the path at the top-right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class WaveCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.7); // Start at 70% height on the left

    // Wave-like curve with two control points
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.9,
        size.width * 0.5, size.height * 0.7);

    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.5, size.width, size.height * 0.7);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
