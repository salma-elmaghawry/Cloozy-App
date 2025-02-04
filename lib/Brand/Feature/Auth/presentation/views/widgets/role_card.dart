import 'package:cloozy/Brand/Core/common/constant.dart';
import 'package:flutter/material.dart';

class RoleCard extends StatelessWidget {
  bool isSelected;

  void Function()? onTap;

  String imagePath;

  String title;

  RoleCard(
      {super.key,
      required this.isSelected,
      required this.onTap,
      required this.title,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? primaryColor : Colors.grey),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(imagePath, height: 80),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
