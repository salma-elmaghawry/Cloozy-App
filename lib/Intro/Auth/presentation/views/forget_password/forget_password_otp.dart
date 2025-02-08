import 'package:cloozy/Core/common/add_logo.dart';
import 'package:cloozy/Core/common/app_dialogs.dart';
import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/common/headline_text_style.dart';
import 'package:cloozy/Core/common/next_botton.dart';
import 'package:cloozy/Core/helper/assets.dart';
import 'package:cloozy/Intro/Auth/presentation/controller/cubits/forget_password/forget_password_cubit.dart';
import 'package:cloozy/Intro/Auth/data/repository/auth_repository.dart';
import 'package:cloozy/Intro/Auth/presentation/views/forget_password/new_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgetPasswordOtp extends StatefulWidget {
  const ForgetPasswordOtp({super.key, required this.email});
  final String email;

  @override
  State<ForgetPasswordOtp> createState() => _ForgetPasswordOtpState();
}

class _ForgetPasswordOtpState extends State<ForgetPasswordOtp> {
  String _otp = '';
  String maskEmail(String email) {
    if (email.isEmpty) return '';
    final parts = email.split('@');
    if (parts.length != 2) return email;
    final username = parts[0];
    final domain = parts[1];
    final maskedUsername =
        username.substring(0, 2) + '*' * (username.length - 2);
    return '$maskedUsername@$domain';
  }

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
                title: "Enter Code",
                color: Colors.black,
                fontSize: 24,
              ),
              CustomText(
                title:
                    "We’ve sent a message with an activation code to your email ${maskEmail(widget.email)}",
                color: grayColor,
                fontSize: 16,
              ),
              const SizedBox(height: 30),
              PinCodeTextField(
                appContext: context,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                cursorColor: primaryColor,
                textStyle: const TextStyle(fontSize: 20),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.grey.shade200,
                  selectedFillColor: Colors.white,
                  selectedColor: primaryColor,
                ),
                onChanged: (value) {
                  setState(() {
                    _otp = value;
                  });
                },
              ),
              const SizedBox(height: 30),
              ButtonWithIcon(
                  text: "Next",
                  onPressed: () {
                    if (_otp.length == 6) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewPasswordPage(
                            email: widget.email,
                            otp: _otp,
                          ),
                        ),
                      );
                    } else {
                      showErrorDialog(
                          context, 'Please enter a valid 6-digit OTP');
                    }
                  },
                  assetpath: shortArrow)
            ],
          ),
        ),
      ),
    );
  }
}
