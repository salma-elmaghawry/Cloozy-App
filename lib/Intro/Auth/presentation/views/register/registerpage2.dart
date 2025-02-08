import 'package:cloozy/Core/common/add_logo.dart';
import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/common/custom_TextFormField.dart';
import 'package:cloozy/Core/common/custom_headline.dart';
import 'package:cloozy/Core/common/custom_snakbar.dart';
import 'package:cloozy/Core/common/cutom_button.dart';
import 'package:cloozy/Core/common/headline_text_style.dart';
import 'package:cloozy/Core/common/linewithtapword.dart';
import 'package:cloozy/Intro/Auth/presentation/controller/cubits/register/register_cubit.dart';
import 'package:cloozy/Intro/Auth/presentation/controller/cubits/verify_email/verify_email_cubit.dart';
import 'package:cloozy/Intro/Auth/data/models/register_model.dart';
import 'package:cloozy/Intro/Auth/presentation/views/login_page.dart';
import 'package:cloozy/Intro/Auth/presentation/views/verify_email/verify_email_screen.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage2 extends StatefulWidget {
  final int roleId;
  final String name, email, phone, gender;

  const RegisterPage2({
    Key? key,
    required this.roleId,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
  }) : super(key: key);

  @override
  _RegisterPage2State createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _selectedGender = 'female';
  bool _agreeToTerms = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
    if (widget.email.isEmpty) {
      showCustomSnackBar(context, "Email is missing. Please try again.", true);
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
    context.read<VerifyEmailCubit>().sendOtp(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: BlocListener<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterLoading) {}
              if (state is RegisterError) {
                showCustomSnackBar(context, state.message, true);
              }
              if (state is RegisterSuccess) {
                if (state.message == 'User registered successfully.') {
                  showCustomSnackBar(context, state.message, false);
                  context.read<VerifyEmailCubit>().sendOtp(widget.email);
                  Future.delayed(const Duration(seconds: 1), () {
                    //send otp here

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              VerifyEmailScreen(email: widget.email)),
                      (routes) => false,
                    );
                  });
                } else {
                  showCustomSnackBar(context, state.message, true);
                }
              }
            },
            child: ListView(
              children: [
                const SizedBox(height: 30),
                const AddLogo(),
                const SizedBox(height: 30),
                CustomText(
                  title: "Sign Up",
                  color: Colors.black,
                  fontSize: 24,
                ),
                CustomText(
                  title: "Create a new account",
                  color: grayColor,
                  fontSize: 16,
                ),
                const SizedBox(height: 30),
                CustomHeadline(title: "Password"),
                const SizedBox(height: 10),
                CustomTextformfield(
                  controller: _passwordController,
                  label: "Password",
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  validator: (value) => value!.length < 8
                      ? "Password must be at least 8 characters"
                      : null,
                ),
                const SizedBox(height: 30),
                CustomHeadline(title: "Confirm Password"),
                const SizedBox(height: 10),
                CustomTextformfield(
                  controller: _confirmPasswordController,
                  label: "Password",
                  obscureText: _obscureConfirmPassword,
                  suffixIcon: IconButton(
                    icon: Icon(_obscureConfirmPassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  validator: (value) => value != _passwordController.text
                      ? "Passwords do not match"
                      : null,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Checkbox(
                      value: _agreeToTerms,
                      activeColor: primaryColor,
                      onChanged: (bool? value) {
                        setState(() {
                          _agreeToTerms = value ?? false;
                        });
                      },
                    ),
                    const Text("I agree to the "),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        "Terms Of Conditions",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    if (state is RegisterLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: primaryColor),
                      );
                    }
                    return CustomButton(
                        text: "Create New Account",
                        onPressed: _validateAndRegister);
                  },
                ),
                const SizedBox(height: 10),
                LineWithAction(
                    actionName: "Login",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(
                            roleId: widget.roleId,
                          ),
                        ),
                      );
                    },
                    title: "Already have an account? "),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
