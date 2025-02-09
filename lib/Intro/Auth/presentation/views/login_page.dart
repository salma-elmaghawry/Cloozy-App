import 'package:cloozy/Brand/Feature/Dashboard/presentation/Screens/botton_navbar.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/Screens/dumy_nav_page/home_page.dart';
import 'package:cloozy/Core/common/app_dialogs.dart';
import 'package:cloozy/Intro/Auth/presentation/controller/cubits/login/login_cubit.dart';
import 'package:cloozy/Intro/Auth/presentation/views/verify_email/verify_email_screen.dart';
import 'package:cloozy/Intro/Auth/presentation/widgets/login_page_body.dart';
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
            showErrorDialog(context, state.message);
          }

          if (state is LoginSuccess) {
            if (state.isEmailVerified) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => BottomNavBar(token: state.token)),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        VerifyEmailScreen(email: _emailController.text)),
              );
            }
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
