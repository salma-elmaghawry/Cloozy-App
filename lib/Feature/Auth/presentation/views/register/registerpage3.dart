import 'package:flutter/material.dart';
import 'package:cloozy/Core/common/custom_TextFormField.dart';
import 'package:cloozy/Core/common/custom_snakbar.dart';

class RegisterPage3 extends StatefulWidget {
  final int roleId;
  final String name, email, phone, gender;

  const RegisterPage3({
    Key? key,
    required this.roleId,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
  }) : super(key: key);

  @override
  _RegisterPage3State createState() => _RegisterPage3State();
}

class _RegisterPage3State extends State<RegisterPage3> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateAndRegister() {
    if (_formKey.currentState!.validate()) {
      // Proceed with registration
      // You can call your API or state management here to complete the registration
      showCustomSnackBar(context, "Registration Successful", false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text("Set Password", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              CustomTextformfield(
                controller: _passwordController,
                label: "Password",
                obscureText: true,
                validator: (value) => value!.length < 8 ? "Password must be at least 8 characters" : null,
              ),
              CustomTextformfield(
                controller: _confirmPasswordController,
                label: "Confirm Password",
                obscureText: true,
                validator: (value) => value != _passwordController.text ? "Passwords do not match" : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _validateAndRegister,
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
