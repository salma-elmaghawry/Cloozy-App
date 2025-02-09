import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AddSvgicon extends StatelessWidget {
  AddSvgicon({super.key, required this.assetPath});
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SvgPicture.asset(assetPath),
    );
  }
}
