import 'package:cloozy/Core/common/custom_TextFormField.dart.dart';
import 'package:flutter/material.dart';

class PasswordConfirmField extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const PasswordConfirmField(
      {super.key,
      required this.passwordController,
      required this.confirmPasswordController});

  @override
  Widget build(BuildContext context) {
    return CustomTextformfield(
      controller: confirmPasswordController,
      label: "Confirm Password",
      suffixIcon: const Icon(Icons.password),
      obscureText: true,
      validator: (value) {
        value != passwordController.text ? 'Passwords do not match' : null;
      },
    );
  }
}
