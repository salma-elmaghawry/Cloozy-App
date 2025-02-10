import 'package:cloozy/Brand/Feature/Dashboard/presentation/Screens/botton_navbar.dart';
import 'package:cloozy/Core/common/add_logo.dart';
import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/common/custom_snakbar.dart';
import 'package:cloozy/Core/common/cutom_button.dart';
import 'package:cloozy/Core/common/headline_text_style.dart';
import 'package:cloozy/Core/common/linewithtapword.dart';
import 'package:cloozy/Intro/Auth/presentation/controller/cubits/verify_email/verify_email_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email;

  const VerifyEmailScreen({Key? key, required this.email}) : super(key: key);

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  String _otp = '';

  @override
  void initState() {
    super.initState();
    //context.read<VerifyEmailCubit>().sendOtp(widget.email);
  }

  void _verifyOtp() {
    if (_otp.length != 6) {
      showCustomSnackBar(context, "Please enter a valid 6-digit OTP", true);
      return;
    }
    context.read<VerifyEmailCubit>().verifyOtp(widget.email, _otp);
  }

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
        padding: const EdgeInsets.all(20.0),
        child: BlocListener<VerifyEmailCubit, VerifyEmailState>(
          listener: (context, state) {
            if (state is VerifyEmailError) {
              showCustomSnackBar(context, state.message, true);
            } else if (state is VerifyOtpError) {
              showCustomSnackBar(context, state.message, true);
            } else if (state is VerifyOtpSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => BottomNavBar(token: state.token),
                ),
                (route) => false,
              );
            }
          },
          child: ListView(
            children: [
              const SizedBox(height: 30),
              const AddLogo(),
              const SizedBox(height: 30),
              CustomText(
                title: "Verify your Email",
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
                onCompleted: (value) {
                  _otp = value;
                  _verifyOtp();
                },
              ),
              const SizedBox(height: 30),
              BlocBuilder<VerifyEmailCubit, VerifyEmailState>(
                builder: (context, state) {
                  if (state is VerifyOtpLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: primaryColor),
                    );
                  }
                  return CustomButton(text: "Verify", onPressed: _verifyOtp);
                },
              ),
              const SizedBox(height: 20),
              BlocBuilder<VerifyEmailCubit, VerifyEmailState>(
                builder: (context, state) {
                  if (state is VerifyEmailLoading) {}

                  return LineWithAction(
                    actionName: "Resend code",
                    onTap: () {
                      context.read<VerifyEmailCubit>().sendOtp(widget.email);
                    },
                    title: "Didn’t receive OTP?",
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
