import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Feature/Auth/data/cubits/login/login_cubit.dart';
import 'package:cloozy/Feature/Auth/data/models/login_model.dart';
import 'package:cloozy/Feature/Auth/presentation/views/widgets/login_page_body.dart';
import 'package:cloozy/Feature/home/presentation/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key,});
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
              MaterialPageRoute(builder: (_) => HomePage(token:"")),
            );
          }
        },
        child: LoginPageBody(
            emailController: _emailController,
            passwordController: _passwordController),
      ),
    );
  }
}
