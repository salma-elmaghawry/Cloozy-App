import 'package:flutter/material.dart';

class CustomTextformfield extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? KeyboardType;
  const CustomTextformfield(
      {super.key,
      required this.controller,
      required this.label,
      this.validator,
      this.obscureText = false,
      this.KeyboardType});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      //decoration
      decoration: InputDecoration(labelText: label),
      obscureText: obscureText,
      validator: validator,
    );
  }
}
