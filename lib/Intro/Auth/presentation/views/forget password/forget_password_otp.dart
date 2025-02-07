import 'package:cloozy/Brand/Core/common/cutom_button.dart';
import 'package:cloozy/Brand/Core/common/next_botton.dart';
import 'package:cloozy/Brand/Core/helper/assets.dart';
import 'package:cloozy/Intro/Auth/presentation/views/forget%20password/new_password.dart';
import 'package:flutter/material.dart';

class ForgetPasswordOtp extends StatelessWidget {
  const ForgetPasswordOtp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [


          
          ButtonWithIcon(
              text: "Next",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewPassword(),
                  ),
                );
              },
              assetpath: shortArrow)
        ],
      ),
    );
  }
}
