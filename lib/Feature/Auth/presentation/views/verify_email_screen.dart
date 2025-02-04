import 'package:cloozy/Feature/Auth/data/cubits/verify_email/verify_email_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:cloozy/Core/common/custom_snakbar.dart';
import 'package:cloozy/Feature/home/presentation/views/home_page.dart';

// Add your VerifyEmailCubit import here

class VerifyEmailScreen extends StatefulWidget {
  final String email;

  const VerifyEmailScreen({Key? key, required this.email}) : super(key: key);

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final OtpFieldController _otpController = OtpFieldController();
  String _otp = '';

  @override
  void initState() {
    super.initState();
    // Send OTP immediately when the screen loads
    context.read<VerifyEmailCubit>().sendOtp(widget.email);
  }

  void _verifyOtp() {
    if (_otp.length != 6) {
      showCustomSnackBar(context, "Please enter a valid 6-digit OTP", true);
      return;
    }
    context.read<VerifyEmailCubit>().verifyOtp(widget.email, _otp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify Email")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocListener<VerifyEmailCubit, VerifyEmailState>(
          listener: (context, state) {
            if (state is VerifyEmailError) {
              showCustomSnackBar(context, state.message, true);
            } else if (state is VerifyOtpError) {
              showCustomSnackBar(context, state.message, true);
            } else if (state is VerifyOtpSuccess) {
              // Navigate to HomePage with the obtained token
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => HomePage(token: state.token),
                ),
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Enter OTP Sent to Your Email",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              OtpTextField(
                numberOfFields: 6,
                controller: _otpController,
                onSubmit: (code) {
                  _otp = code;
                  _verifyOtp();
                },
                keyboardType: TextInputType.number,
                cursorColor: Colors.blue,
                textStyle: const TextStyle(fontSize: 20),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                enabledBorderColor: Colors.grey,
                focusedBorderColor: Colors.blue,
                showFieldAsBox: true,
              ),
              const SizedBox(height: 30),
              BlocBuilder<VerifyEmailCubit, VerifyEmailState>(
                builder: (context, state) {
                  if (state is VerifyOtpLoading) {
                    return const CircularProgressIndicator();
                  }
                  return ElevatedButton(
                    onPressed: _verifyOtp,
                    child: const Text("Verify OTP"),
                  );
                },
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Resend OTP
                  context.read<VerifyEmailCubit>().sendOtp(widget.email);
                },
                child: const Text("Resend Code"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
