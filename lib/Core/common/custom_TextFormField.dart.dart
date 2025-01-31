import 'package:cloozy/Core/common/constant.dart';
import 'package:flutter/material.dart';

class CustomTextformfield extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? KeyboardType;
  Widget? suffixIcon;
  CustomTextformfield(
      {super.key,
      required this.controller,
      required this.label,
      this.validator,
      this.suffixIcon,
      this.obscureText = false,
      this.KeyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      //decoration
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: PrimaryColor,
              width: 2.0,
            ),
          )),

      obscureText: obscureText,
      validator: validator,
    );
  }
}
