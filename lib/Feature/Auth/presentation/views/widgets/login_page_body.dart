import 'package:cloozy/Core/common/add_logo.dart';
import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/common/custom_TextFormField.dart.dart';
import 'package:cloozy/Core/common/cutom_button.dart';
import 'package:cloozy/Core/common/headline_text_style.dart';
import 'package:cloozy/Core/common/custom_text_button.dart';
import 'package:cloozy/Feature/Auth/presentation/views/widgets/social_media_login.dart';
import 'package:cloozy/Feature/Auth/data/cubits/login/login_cubit.dart';
import 'package:cloozy/Feature/Auth/presentation/views/forget_password.dart';
import 'package:cloozy/Feature/Auth/presentation/views/registerpage1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPageBody extends StatefulWidget {
  const LoginPageBody({
    super.key,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _emailController = emailController,
        _passwordController = passwordController;

  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          SizedBox(height: 10),
          addLogo(),
          customText(
            title: "Welcome Back!",
            color: Colors.black,
            fontSize: 24,
          ),
          customText(
            title: "Please login or sign up to get started",
            color: grayColor,
            fontSize: 16,
          ),
          const SizedBox(height: 30),
          CustomTextformfield(
            controller: widget._emailController,
            label: "Email",
            validator: (value) => value!.contains('@') ? null : 'Invalid email',
          ),
          const SizedBox(height: 30),
          CustomTextformfield(
            controller: widget._passwordController,
            label: "Password",
            obscureText: true,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                      value: isChecked,
                      splashRadius: 25,
                      activeColor: grayColor,
                      checkColor: PrimaryColor,
                      //focusColor: grayColor,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      }),
                  Text(
                    "Remember Me",
                    style: TextStyle(
                      color: isChecked
                          ? PrimaryColor
                          : const Color.fromARGB(255, 192, 192, 192),
                    ),
                  )
                ],
              ),
              Spacer(),
              CustomTextButton(
                  title: "Forgot password?",
                  color: PrimaryColor,
                  fontSize: 12,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => ForgetPassword()),
                    );
                  }),
              SizedBox(height: 10),
            ],
          ),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              if (state is LoginLoading) {
                return CircularProgressIndicator(color: PrimaryColor);
              }
              return CustomButton(
                onPressed: () {
                  if (widget._emailController.text.isNotEmpty &&
                      widget._passwordController.text.isNotEmpty) {
                    context.read<LoginCubit>().loginUser(
                          widget._emailController.text,
                          widget._passwordController.text,
                        );
                  }
                },
                text: 'Login',
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customText(
                title: "Don't have an account? ",
                color: Colors.black,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return RegisterPage();
                  }));
                },
                child: customText(
                  title: "SignUp",
                  color: PrimaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text("Or continue with"),
              ),
              Expanded(child: Divider()),
            ],
          ),
          const SizedBox(height: 30),
          SocialMediaLogin()
        ],
      ),
    );
  }
}
