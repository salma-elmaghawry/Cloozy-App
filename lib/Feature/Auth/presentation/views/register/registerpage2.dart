import 'package:cloozy/Core/common/add_logo.dart';
import 'package:cloozy/Core/common/custom_TextFormField.dart';
import 'package:cloozy/Core/common/custom_snakbar.dart';
import 'package:cloozy/Core/common/cutom_button.dart';
import 'package:cloozy/Core/common/linewithtapword.dart';
import 'package:cloozy/Feature/Auth/data/cubits/register/register_cubit.dart';
import 'package:cloozy/Feature/Auth/data/models/register_model.dart';
import 'package:cloozy/Feature/Auth/presentation/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:cloozy/Feature/Auth/presentation/views/widgets/password_confirm_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage2 extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String gender;
  final int selectedRoleId;

  RegisterPage2({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.selectedRoleId,
  });

  @override
  _RegisterPage2State createState() => _RegisterPage2State();
}

class _RegisterPage2State extends State<RegisterPage2> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              const AddLogo(),
              const SizedBox(height: 20),
              const Text("Sign Up",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const Text("Create a new account",
                  style: TextStyle(fontSize: 18, color: Colors.grey)),
              const SizedBox(height: 20),
              CustomTextformfield(
                controller: _passwordController,
                label: "Password",
                suffixIcon: const Icon(Icons.lock),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) return "Required";
                  if (value.length < 8) return "Password must be at least 8 characters";
                  return null;
                },
              ),
              const SizedBox(height: 20),
              PasswordConfirmField(
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
              ),
              Row(
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        _agreeToTerms = value!;
                      });
                    },
                  ),
                  const Text("I agree to the "),
                  const Text(
                    "Terms Of Conditions",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              CustomButton(
                  text: "Create new account",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (!_agreeToTerms) {
                        showCustomSnackBar(context, "You must agree to the terms and conditions", true);
                        return;
                      }
                      final request = RegisterRequest(
                        name: widget.name,
                        email: widget.email,
                        phone: widget.phone,
                        password: _passwordController.text,
                        gender: widget.gender,
                        passwordConfirmation: _confirmPasswordController.text,
                        roleId: widget.selectedRoleId,
                      );
                      context.read<RegisterCubit>().registerUser(request);
                    }
                  }),
              const SizedBox(height: 20),
              LineWithAction(
                  actionName: "Login",
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }));
                  },
                  title: "Already have an account? ")
            ],
          ),
        ),
      ),
    );
  }
}