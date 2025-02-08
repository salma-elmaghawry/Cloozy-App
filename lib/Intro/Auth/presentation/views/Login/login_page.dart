import 'package:cloozy/Intro/Auth/data/cubits/login/login_cubit.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/views/home_page.dart';
import 'package:cloozy/Intro/Auth/presentation/views/Login/login_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final int roleId;
  LoginPage({
    super.key,
    required this.roleId,
  });
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              MaterialPageRoute(
                  builder: (_) => DashboardPage(token: state.token)),
            );
          }
        },
        child: LoginPageBody(
            roleId: roleId,
            emailController: _emailController,
            passwordController: _passwordController),
      ),
    );
  }
}
