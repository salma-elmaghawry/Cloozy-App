import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/common/headline_text_style.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final CustomClipper<Path> clipper;
  const OnboardingPage({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.clipper,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Curved Image
        ClipPath(
          clipper: clipper,
          child: Image.asset(
            imageUrl,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.7,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 10),

        // Title
        customText(
          title: title,
          color: PrimaryColor,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),

        const SizedBox(height: 10),

        // Description
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            description,
            style: TextStyle(fontSize: 14, color: grayColor),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

// Custom Clipper for Curved Image
class CustomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.8); // Start at 80% height on the left

    // Adjust the control points for a more balanced curve
    path.quadraticBezierTo(
        size.width / 2, size.height * 1.0, size.width, size.height * 0.8);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Model for Onboarding Data
class OnboardingData {
  final String image;
  final String title;
  final String description;
  final CustomClipper<Path> clipper;

  OnboardingData(
      {required this.image,
      required this.title,
      required this.description,
      required this.clipper});
}
