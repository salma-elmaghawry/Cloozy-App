import 'package:cloozy/Core/common/constant.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const OnboardingPage({
    Key? key,
    required this.title,
    required this.description,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Curved Image
        ClipPath(
          clipper: CustomCurveClipper(),
          child: Image.asset(
            imageUrl,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 20),

        // Title
        Text(
          title,
          style: TextStyle(
              fontSize: 24, color: PrimaryColor, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 10),

        // Description
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            description,
            style: TextStyle(fontSize: 16, color: grayColor),
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
    path.lineTo(0, size.height * 0.85);

    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height * 0.85);

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

  OnboardingData({
    required this.image,
    required this.title,
    required this.description,
  });
}
