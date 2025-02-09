import 'package:cloozy/Core/common/add_logo.dart';
import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/common/custom_TextFormField.dart';
import 'package:cloozy/Core/common/custom_headline.dart';
import 'package:cloozy/Core/common/custom_text_button.dart';
import 'package:cloozy/Core/common/cutom_button.dart';
import 'package:cloozy/Core/common/headline_text_style.dart';
import 'package:cloozy/Core/common/linewithtapword.dart';
import 'package:cloozy/Core/helper/assets.dart';
import 'package:cloozy/Intro/Auth/presentation/controller/cubits/login/login_cubit.dart';
import 'package:cloozy/Intro/Auth/presentation/views/forget_password/email_page.dart';
import 'package:cloozy/Intro/Auth/presentation/views/forget_password/new_password.dart';
import 'package:cloozy/Intro/Auth/presentation/views/register/registerpage1.dart';
import 'package:cloozy/Intro/Auth/presentation/widgets/social_media_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class LoginPageBody extends StatefulWidget {
  final int roleId;

  LoginPageBody({
    super.key,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required this.roleId,
  })  : _emailController = emailController,
        _passwordController = passwordController;

  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  bool isChecked = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const SizedBox(height: 30),
          const AddLogo(),
          const SizedBox(height: 40),
          CustomText(
            title: "Welcome Back!",
            color: Colors.black,
            fontSize: 24,
          ),
          CustomText(
            title: "Please login or sign up to get started",
            color: grayColor,
            fontSize: 16,
          ),
          const SizedBox(height: 30),
          CustomHeadline(title: "Email"),
          const SizedBox(height: 10),
          CustomTextformfield(
            controller: widget._emailController,
            label: "Email",
            suffixIcon: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                email,
              ),
            ),
            validator: (value) => value!.contains('@') ? null : 'Invalid email',
          ),
          const SizedBox(height: 30),
          CustomHeadline(title: "Password"),
          const SizedBox(height: 10),
          CustomTextformfield(
            controller: widget._passwordController,
            label: "Password",
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
            obscureText: _obscurePassword,
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
                      activeColor: primaryColor,

                      //focusColor: grayColor,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      }),
                  Text(
                    "Remember Me",
                    style: TextStyle(
                      color: isChecked ? primaryColor : grayColor,
                    ),
                  )
                ],
              ),
              const Spacer(),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EmailPage()),
                    );
                  },
                  child:const  Text(
                    "Forgot password?",
                    style: TextStyle(
                        fontSize: 16,
                        color: primaryColor,
                        fontWeight: FontWeight.w500),
                  )),
            ],
          ),
          const SizedBox(height: 20),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              if (state is LoginLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: primaryColor),
                );
              }
              return CustomButton(
                onPressed: () {
                  if (widget._emailController.text.isNotEmpty &&
                      widget._passwordController.text.isNotEmpty) {
                    context.read<LoginCubit>().loginUser(
                        widget._emailController.text,
                        widget._passwordController.text,
                        isChecked);
                  }
                },
                text: 'Login',
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          LineWithAction(
            title: "Don't have an account? ",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return RegisterPage1(roleId: widget.roleId);
              }));
            },
            actionName: "SignUp",
          ),
          const SizedBox(height: 30),
          const Row(
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: const SocialMediaLogin(),
          )
        ],
      ),
    );
  }
}
