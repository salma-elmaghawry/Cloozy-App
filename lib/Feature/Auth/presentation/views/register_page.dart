import 'package:cloozy/Core/common/assets.dart';
import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/common/custom_TextFormField.dart.dart';
import 'package:cloozy/Core/common/custom_snakbar.dart';
import 'package:cloozy/Core/common/cutom_button.dart';
import 'package:cloozy/Core/common/gender_drop_down.dart';
import 'package:cloozy/Feature/Auth/data/cubits/register/register_cubit.dart';
import 'package:cloozy/Feature/Auth/data/models/register_model.dart';
import 'package:cloozy/Feature/Auth/presentation/views/widgets/password_confirm_field.dart';
import 'package:cloozy/Feature/home/presentation/views/home_page.dart';
import 'package:cloozy/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _gender = 'female';
  int? _selectedRoleId;

  final List<Map<String, dynamic>> _roles = [
    {'id': 2, 'name': 'Brand'},
    {'id': 3, 'name': 'Customer'},
  ];

  @override
  Widget build(BuildContext context) {
    print('[RegisterPage] Initial gender value: $_gender');
    print('[RegisterPage] Initial role ID: $_selectedRoleId');
    return Scaffold(
      backgroundColor: bgColor,
      body: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterError) {
            print('[RegisterPage] Error occurred: ${state.message}');
            showCustomSnackBar(context, state.message, true);
          }
          if (state is RegisterSuccess) {
            if (state.message == 'User registered successfully.') {
              showCustomSnackBar(context, state.message, false);
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => HomePage()),
                );
              });
            } else {
              showCustomSnackBar(context, state.message, true);
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 10),
                  Image.asset(logo),
                  const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const Text('Create anew account',
                      style: TextStyle(color: Colors.grey, fontSize: 20)),
                  const SizedBox(height: 20),
                  //Name
                  CustomTextformfield(
                    controller: _nameController,
                    label: "Name",
                    suffixIcon: Icon(Icons.person),
                    validator: (value) {
                      return value!.isEmpty ? "Required" : null; // Added return
                    },
                  ),
                  const SizedBox(height: 20),
                  //Email
                  CustomTextformfield(
                      controller: _emailController,
                      label: "Email",
                      suffixIcon: Icon(Icons.email_outlined),
                      validator: (value) =>
                          value!.contains('@') ? null : "Invalid email"),
                  const SizedBox(height: 20),
                  //Phone
                  CustomTextformfield(
                    controller: _phoneController,
                    label: "Phone",
                    suffixIcon: Icon(Icons.tag),
                    KeyboardType: TextInputType.phone,
                    validator: (value) =>
                        value!.length < 10 ? "Invalid phone number" : null,
                  ),
                  const SizedBox(height: 20),
                  //Password
                  CustomTextformfield(
                    controller: _passwordController,
                    label: "Password",
                    suffixIcon: Icon(Icons.password_sharp),
                    obscureText: true,
                    validator: (value) =>
                        value!.length < 8 ? "Too short" : null,
                  ),
                  const SizedBox(height: 20),
                  //confirm Password
                  PasswordConfirmField(
                      passwordController: _passwordController,
                      confirmPasswordController: _confirmPasswordController),
                  //gender
                  GenderDropdown(
                      value: _gender, onChange: (value) => _gender = value!),
                  //Select role

                  DropdownButtonFormField<int>(
                    value: _selectedRoleId,
                    decoration: const InputDecoration(labelText: 'Select Role'),
                    items: _roles.map((role) {
                      return DropdownMenuItem<int>(
                        value: role['id'] as int, // Explicit cast to int
                        child: Text(role['name']),
                      );
                    }).toList(),
                    onChanged: (value) => _selectedRoleId = value,
                    validator: (value) =>
                        value == null ? 'Please select a role' : null,
                  ),
                  SizedBox(height: 40),
                  BlocBuilder<RegisterCubit, RegisterState>(
                      builder: (context, state) {
                    if (state is RegisterLoading) {
                      return Center(child: CircularProgressIndicator(color: PrimaryColor,));
                    }
                    return CustomButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final request = RegisterRequest(
                              name: _nameController.text,
                              email: _emailController.text,
                              phone: _phoneController.text,
                              password: _passwordController.text,
                              gender: _gender,
                              passwordConfirmation:
                                  _confirmPasswordController.text,
                              roleId: _selectedRoleId!,
                            );
                            print(
                                '[RegisterPage] Sending request: ${request.toJson()}');
                            context.read<RegisterCubit>().registerUser(request);
                          }
                        },
                        text: "Create New Account");
                  })
                ],
              )),
        ),
      ),
    );
  }
}
