import 'package:cloozy/Brand/Core/common/add_logo.dart';
import 'package:cloozy/Brand/Core/common/constant.dart';
import 'package:cloozy/Brand/Core/common/custom_TextFormField.dart';
import 'package:cloozy/Brand/Core/common/custom_headline.dart';
import 'package:cloozy/Brand/Core/common/cutom_button.dart';
import 'package:cloozy/Brand/Core/common/headline_text_style.dart';
import 'package:cloozy/Brand/Core/common/next_botton.dart';
import 'package:cloozy/Brand/Core/helper/assets.dart';
import 'package:cloozy/Intro/Auth/presentation/views/forget%20password/forget_password_otp.dart';
import 'package:flutter/material.dart';

class EmailPage extends StatelessWidget {
  EmailPage({super.key});
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(height: 30),
          const AddLogo(),
          const SizedBox(height: 30),
          customText(
            title: "Forget Password",
            color: Colors.black,
            fontSize: 24,
          ),
          customText(
            title: "Please enter your email to send reset code",
            color: grayColor,
            fontSize: 16,
          ),
          const SizedBox(height: 30),
          CustomHeadline(title: "Email"),
          CustomTextformfield(
              controller: _passwordController, label: "Password"),
          ButtonWithIcon(
            text: "Next",
            onPressed: () {
              Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ForgetPasswordOtp(),
        ),
      );
            },
            assetpath: shortArrow,
          ),
        ],
      ),
    );
  }
}
