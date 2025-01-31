// import 'package:cloozy/Core/common/custom_TextFormField.dart.dart';
// import 'package:cloozy/Core/common/cutom_button.dart';
// import 'package:cloozy/Features/Auth/views/widgets/password_confirm_field.dart';
// import 'package:flutter/material.dart';

// class RegisterPage2 extends StatelessWidget {
//    final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();
//    RegisterPage2({super.key});
  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Form(
//         child: ListView(
//           children: [
        
//           CustomTextformfield(
//                       controller: _passwordController,
//                       label: "Password",
//                       obscureText: true,
//                       validator: (value) =>
//                           value!.length < 6 ? "Too short" : null,
//                     ),
//                     //confirm Password
//                     PasswordConfirmField(
//                         passwordController: _passwordController,
//                         confirmPasswordController: _confirmPasswordController),
//                         CutomButton(onPressed: (){
//                            if (_formKey.currentState!.validate()) {
//                             print('[RegisterPage] Form validated successfully');
//                             print('[RegisterPage] Gender value: $_gender');
//                             print('[RegisterPage] Role ID: $_selectedRoleId');
//                             final request = RegisterRequest(
//                               name: _nameController.text,
//                               email: _emailController.text,
//                               phone: _phoneController.text,
//                               password: _passwordController.text,
//                               gender: _gender,
//                               passwordConfirmation:
//                                   _confirmPasswordController.text,
//                               roleId: _selectedRoleId!,
//                             );
//                             print(
//                                 '[RegisterPage] Sending request: ${request.toJson()}');
//                             context.read<RegisterCubit>().registerUser(request);
//                           }
//                         }, text: "Create New account")
                        
//           ]
//         ),
//       ),
      

//     );
//   }
// }
