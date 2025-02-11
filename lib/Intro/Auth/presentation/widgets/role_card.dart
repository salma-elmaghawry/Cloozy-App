import 'package:cloozy/Core/common/constant.dart';
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
          width: 146,
          height: 250,
          padding:const  EdgeInsets.all(10),
          decoration: BoxDecoration(
            border:
                isSelected ? Border.all(color: primaryColor, width: 2.0) : null,
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Image Container
              Positioned(
                top: 10,
                left: 10,
                right: 10,
                bottom: 30,
                child: Container(
                  height: 160, // Fixed height for the image
                  decoration: BoxDecoration(
                    // borderRadius:
                    //    // BorderRadius.vertical(top: Radius.circular(12)),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit:
                          BoxFit.cover, // Ensures the image fills the container
                    ),
                  ),
                ),
              ),
              // Title Container
              Positioned(
                bottom: 1,
                child: Text(
                  title,
                  style: const  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
