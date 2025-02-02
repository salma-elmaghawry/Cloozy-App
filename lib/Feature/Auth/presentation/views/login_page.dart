import 'package:cloozy/Core/common/assets.dart';
import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/common/custom_TextFormField.dart.dart';
import 'package:cloozy/Core/common/cutom_button.dart';
import 'package:cloozy/Feature/Auth/data/cubits/login/login_cubit.dart';
import 'package:cloozy/Feature/home/presentation/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is LoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomePage()),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              SizedBox(height: 10),
              Image.asset(logo),
              const Text(
                'Sign In',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const Text('Welcome Back ',
                  style: TextStyle(color: Colors.grey, fontSize: 20)),
              const SizedBox(height: 20),
              CustomTextformfield(
                controller: _emailController,
                label: "Email",
                validator: (value) =>
                    value!.contains('@') ? null : 'Invalid email',
              ),
              CustomTextformfield(
                controller: _passwordController,
                label: "Password",
                obscureText: true,
              ),
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return CircularProgressIndicator(color: PrimaryColor);
                  }
                  return CustomButton(
                    onPressed: () {
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        context.read<LoginCubit>().loginUser(
                              _emailController.text,
                              _passwordController.text,
                            );
                      }
                    },
                    text: 'Login',
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
