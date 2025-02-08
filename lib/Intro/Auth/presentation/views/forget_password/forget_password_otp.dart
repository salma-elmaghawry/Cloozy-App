import 'package:cloozy/Brand/Core/common/add_logo.dart';
import 'package:cloozy/Brand/Core/common/constant.dart';
import 'package:cloozy/Brand/Core/common/cutom_button.dart';
import 'package:cloozy/Brand/Core/common/headline_text_style.dart';
import 'package:cloozy/Brand/Core/common/next_botton.dart';
import 'package:cloozy/Brand/Core/helper/assets.dart';
import 'package:cloozy/Intro/Auth/presentation/views/forget_password/new_password.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            const AddLogo(),
            const SizedBox(height: 30),
            customText(
              title: "Enter Code",
              color: Colors.black,
              fontSize: 24,
            ),
            customText(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewPasswordPage(
                        email: widget.email,
                        otp: _otp,
                      ),
                    ),
                  );
                },
                assetpath: shortArrow)
          ],
        ),
      ),
    );
  }
}
