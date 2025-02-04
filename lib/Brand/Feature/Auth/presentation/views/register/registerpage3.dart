import 'package:cloozy/Brand/Core/common/custom_TextFormField.dart';
import 'package:cloozy/Brand/Core/common/custom_snakbar.dart';
import 'package:cloozy/Brand/Feature/Auth/data/cubits/register/register_cubit.dart';
import 'package:cloozy/Brand/Feature/Auth/presentation/views/verify_email_screen.dart';
import 'package:cloozy/Feature/Auth/data/models/register_model.dart';
import 'package:cloozy/Feature/home/presentation/views/home_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

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
  final TextEditingController _confirmPasswordController =
      TextEditingController();
   String _selectedGender = 'female';
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateAndRegister() {
    if (!_agreeToTerms) {
      showCustomSnackBar(
          context, "You must agree to the terms and conditions", true);
      return;
    }
    final request = RegisterRequest(
      name: widget.name,
      email: widget.email,
      phone: widget.phone,
      password: _passwordController.text,
      gender: widget.gender,
      passwordConfirmation: _confirmPasswordController.text,
      roleId: widget.roleId,
    );
    context.read<RegisterCubit>().registerUser(request);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: BlocListener<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterError) {
                showCustomSnackBar(context, state.message, true);
              }
              if (state is RegisterSuccess) {
                if (state.message == 'User registered successfully.') {
                  showCustomSnackBar(context, state.message, false);
                  Future.delayed(const Duration(seconds: 1), () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => VerifyEmailScreen(email:widget.email)),
                    );
                  });
                } else {
                  showCustomSnackBar(context, state.message, true);
                }
              }
            },
            child: ListView(
              children: [
                const Text("Set Password",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                CustomTextformfield(
                  controller: _passwordController,
                  label: "Password",
                  obscureText: true,
                  validator: (value) => value!.length < 8
                      ? "Password must be at least 8 characters"
                      : null,
                ),
                CustomTextformfield(
                  controller: _confirmPasswordController,
                  label: "Confirm Password",
                  obscureText: true,
                  validator: (value) => value != _passwordController.text
                      ? "Passwords do not match"
                      : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _validateAndRegister,
                  child: const Text("Register"),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Checkbox(
                      value: _agreeToTerms,
                      onChanged: (bool? value) {
                        setState(() {
                          _agreeToTerms = value ?? false;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text(
                        "I agree to the terms and conditions",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
