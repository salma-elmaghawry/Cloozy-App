import 'package:cloozy/Core/common/add_logo.dart';
import 'package:cloozy/Core/common/app_dialogs.dart';
import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/common/custom_TextFormField.dart';
import 'package:cloozy/Core/common/custom_headline.dart';
import 'package:cloozy/Core/common/headline_text_style.dart';
import 'package:cloozy/Core/common/next_botton.dart';
import 'package:cloozy/Core/helper/assets.dart';
import 'package:cloozy/Intro/Auth/presentation/controller/cubits/forget_password/forget_password_cubit.dart';
import 'package:cloozy/Intro/Auth/data/repository/auth_repository.dart';
import 'package:cloozy/Intro/Auth/presentation/views/forget_password/forget_password_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class EmailPage extends StatefulWidget {
  EmailPage({super.key});

  @override
  State<EmailPage> createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  final TextEditingController _emailController = TextEditingController();

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
                title: "Forget Password",
                color: Colors.black,
                fontSize: 24,
              ),
              CustomText(
                title: "Please enter your email to send reset code",
                color: grayColor,
                fontSize: 16,
              ),
              const SizedBox(height: 30),
              CustomHeadline(title: "Email"),
              const SizedBox(height: 10),
              CustomTextformfield(
                controller: _emailController,
                label: "ُEmail",
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    email,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
                listener: (context, state) {
                  if (state is ForgotPasswordEmailSent) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ForgetPasswordOtp(email: _emailController.text),
                      ),
                    );
                  } else if (state is ForgotPasswordError) {
                    showSuccessDialog;
                  }
                },
                builder: (context, state) {
                  if (state is ForgotPasswordLoading) {
                    return Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    );
                  }
                  return ButtonWithIcon(
                    text: "Next",
                    onPressed: () {
                      context
                          .read<ForgetPasswordCubit>()
                          .sendRecoveryEmail(_emailController.text);
                    },
                    assetpath: shortArrow,
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
