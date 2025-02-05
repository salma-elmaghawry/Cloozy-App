import 'package:cloozy/Brand/Core/common/add_logo.dart';
import 'package:cloozy/Brand/Core/common/constant.dart';
import 'package:cloozy/Brand/Core/common/custom_TextFormField.dart';
import 'package:cloozy/Brand/Core/common/cutom_button.dart';
import 'package:cloozy/Brand/Core/common/headline_text_style.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const SizedBox(height: 30),
          const AddLogo(),
          const SizedBox(height: 30),
          customText(
            title: "New Password",
            color: Colors.black,
            fontSize: 24,
          ),
          customText(
            title: "Create a new password",
            color: grayColor,
            fontSize: 16,
          ),
          const SizedBox(height: 30),
          CustomTextformfield(
            controller: _passwordController,
            label: "Password",
            obscureText: true,
            validator: (value) => value!.length < 8
                ? "Password must be at least 8 characters"
                : null,
          ),
          const SizedBox(height: 30),
          CustomTextformfield(
            controller: _confirmPasswordController,
            label: "Confirm Password",
            obscureText: true,
            validator: (value) => value != _passwordController.text
                ? "Passwords do not match"
                : null,
          ),
          CustomButton(text: "Create new password", onPressed: () {}),
        ],
      ),
    );
  }
}
