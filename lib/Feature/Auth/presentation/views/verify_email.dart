// import 'package:cloozy/Core/common/custom_TextFormField.dart';
// import 'package:cloozy/Core/common/cutom_button.dart';
// import 'package:cloozy/Feature/Auth/presentation/views/verify_otp.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class VerifyEmail extends StatefulWidget {
//   final String email;
 
//   const VerifyEmail({super.key, required this.email,});

//   @override
//   State<VerifyEmail> createState() => _VerifyEmailState();
// }

// class _VerifyEmailState extends State<VerifyEmail> {
// //get it email and token 
//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController _emailController = TextEditingController();
//     return Scaffold(
//       body: ListView(
//         children: [
//           //enter your email
//           CustomTextformfield(controller: _emailController, label: "Email"),
//           CustomButton(text: "Next", onPressed: (){
//             Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => VerifyOtp(),
//         ),
//       );
//           })
//         ],
//       ),
//     );
//   }
// }
