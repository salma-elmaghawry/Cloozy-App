import 'package:cloozy/Core/helper/assets.dart';
import 'package:flutter/material.dart';

class SocialMediaLogin extends StatelessWidget {
  const SocialMediaLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Image.asset(facebookLogo),
              const Text(" Facebook", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
        const SizedBox(width: 50),
        Container(
          padding:const  EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Image.asset(googleLogo),
              const SizedBox(width: 10),
              const Text("Google", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }
}
