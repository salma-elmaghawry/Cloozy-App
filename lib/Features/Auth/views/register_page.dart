import 'package:cloozy/Core/common/custom_TextFormField.dart.dart';
import 'package:cloozy/Core/common/gender_drop_down.dart';
import 'package:cloozy/Features/Auth/manager/cubits/register/register_cubit.dart';
import 'package:cloozy/Features/Auth/manager/models/register_model.dart';
import 'package:cloozy/Features/Auth/views/widgets/password_confirm_field.dart';
import 'package:cloozy/Features/home/home_page.dart';
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
  String _gender = 'Female';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register Page",
        ),
        centerTitle: true,
      ),
      body: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is RegisterSuccess) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(
                  builder: (_)=>HomePage()),
                );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  //Name
                  CustomTextformfield(
                    controller: _nameController,
                    label: "Name",
                    validator: (value) {
                      value!.isEmpty ? "Required" : null;
                    },
                  ),
                  //Email
                  CustomTextformfield(
                      controller: _emailController,
                      label: "Email",
                      validator: (value) =>
                          value!.contains('@') ? null : "Invalid email"),
                  //Phone
                  CustomTextformfield(
                    controller: _phoneController,
                    label: "Phone",
                    KeyboardType: TextInputType.phone,
                    validator: (value) =>
                        value!.length < 10 ? "Invalid phone number" : null,
                  ),
                  //Password
                  CustomTextformfield(
                    controller: _passwordController,
                    label: "Password",
                    obscureText: true,
                    validator: (value) =>
                        value!.length < 6 ? "Too short" : null,
                  ),
                  //confirm Password
                  PasswordConfirmField(
                      passwordController: _passwordController,
                      confirmPasswordController: _confirmPasswordController),
                  //gender
                  GenderDropdown(
                      value: _gender, onChange: (value) => _gender = value!),
                  SizedBox(height: 40),
                  BlocBuilder<RegisterCubit, RegisterState>(
                      builder: (context, state) {
                    if (state is RegisterLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final request = RegisterRequest(
                                name: _nameController.text,
                                email: _emailController.text,
                                phone: _phoneController.text,
                                password: _passwordController.text,
                                gender: _gender,
                                passwordConfirmation:
                                    _confirmPasswordController.text);

                            context.read<RegisterCubit>().registerUser(request);
                          }
                        },
                        child: Text("Register"));
                  })
                ],
              )),
        ),
      ),
    );
  }
}
