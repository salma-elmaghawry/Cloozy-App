import 'package:cloozy/Core/common/add_logo.dart';
import 'package:cloozy/Core/common/app_dialogs.dart';
import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/common/custom_TextFormField.dart';
import 'package:cloozy/Core/common/custom_headline.dart';
import 'package:cloozy/Core/common/cutom_button.dart';
import 'package:cloozy/Core/common/headline_text_style.dart';
import 'package:cloozy/Intro/Auth/presentation/controller/cubits/forget_password/forget_password_cubit.dart';
import 'package:cloozy/Intro/Auth/data/repository/auth_repository.dart';
import 'package:cloozy/Intro/Auth/presentation/views/customer_or_brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPasswordPage extends StatefulWidget {
  NewPasswordPage({super.key, required this.otp, required this.email});
  final String otp;
  final String email;

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _obscurenewPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgetPasswordCubit(AuthRepository()),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const SizedBox(height: 30),
              const AddLogo(),
              const SizedBox(height: 30),
              CustomText(
                title: "New Password",
                color: Colors.black,
                fontSize: 24,
              ),
              CustomText(
                title: "Create a new password",
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
                      : Icons.visibility_off),
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
              CustomHeadline(title: "New Password"),
              const SizedBox(height: 10),
              CustomTextformfield(
                controller: _confirmPasswordController,
                label: "Confirm Password",
                obscureText: _obscurenewPassword,
                suffixIcon: IconButton(
                  icon: Icon(_obscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscurenewPassword = !_obscurenewPassword;
                    });
                  },
                ),
                validator: (value) => value != _passwordController.text
                    ? "Passwords do not match"
                    : null,
              ),
              const SizedBox(height: 30),
              BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                listener: (context, state) {
                  if (state is ForgotPasswordSuccess) {
                    showSuccessDialog(context, state.message);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CustomerOrBrand(),
                      ),
                    );
                  } else if (state is ForgotPasswordError) {
                    showErrorDialog(context, state.message);
                  }
                },
                builder: (context, state) {
                  if (state is ForgotPasswordLoading) {
                    return Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    );
                  }
                  return CustomButton(
                    text: "Create New Password",
                    onPressed: () {
                      if (_passwordController.text ==
                          _confirmPasswordController.text) {
                        context.read<ForgetPasswordCubit>().resetPassword(
                              email: widget.email,
                              newPassword: _passwordController.text,
                              newPasswordConfirmation:
                                  _confirmPasswordController.text,
                              otp: widget.otp,
                            );
                      } else {
                        showErrorDialog(context, 'Passwords do not match');
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
